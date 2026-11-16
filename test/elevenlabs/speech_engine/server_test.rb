# frozen_string_literal: true

require 'minitest/autorun'
require 'json'
require 'socket'
require 'timeout'
require 'websocket/driver'
require 'elevenlabs/speech_engine/server'

module Elevenlabs
  module SpeechEngine
    class ServerTest < Minitest::Test
      API_KEY = 'sk_0123456789abcdef0123456789abcdef'
      # The shared golden Speech Engine JWT (exp far in the future), signed with
      # sha256(API_KEY). See JwtVerifierTest.
      TOKEN = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9' \
              '.eyJpc3MiOiJodHRwczovL2FwaS5lbGV2ZW5sYWJzLmlvL2NvbnZhaS9zcGVlY2gtZW5naW5lIiwic3ViIjoiY29udmFpX3NwZWVjaF9lbmdpbmVfdXBzdHJlYW0iLCJpYXQiOjEyMzQ1Njc4OTAsImV4cCI6NDEwMjQ0NDgwMH0' \
              '.UObM4hx1W8NvGViU3aqPv1-IEXhmXgWDgoS9RZZWILk'

      # A minimal websocket-driver client sink: the driver writes handshake and
      # frame bytes here, we relay them to the TCP socket.
      ClientSink = Struct.new(:url, :io) do
        def write(data)
          io.write(data)
        end
      end

      def test_serve_without_api_key_raises
        server = Server.new(port: 0)

        error = assert_raises(RuntimeError) { server.serve }
        assert_includes error.message, 'requires an API key'
      end

      def test_end_to_end_handshake_ping_and_transcript_response
        server = Server.new(
          port: 0,
          api_key: API_KEY,
          handlers: { on_transcript: ->(_transcript, session) { session.send_response('hi there') } },
        )
        server_thread = Thread.new { server.serve }
        wait_until { server.bound_port }

        io = TCPSocket.new('127.0.0.1', server.bound_port)
        messages = Thread::Queue.new
        opened = Thread::Queue.new
        client = ::WebSocket::Driver.client(ClientSink.new("ws://127.0.0.1:#{server.bound_port}/", io))
        client.set_header('X-ElevenLabs-Speech-Engine-Authorization', TOKEN)
        client.on(:open) { opened << true }
        client.on(:message) { |e| messages << e.data }
        client.start
        reader = Thread.new do
          loop { client.parse(io.readpartial(4096)) }
        rescue IOError, Errno::ECONNRESET
          nil
        end

        Timeout.timeout(5) { opened.pop }

        client.text('{"type":"ping"}')

        assert_equal({ 'type' => 'pong' }, next_message(messages))

        client.text('{"type":"user_transcript","event_id":9,"user_transcript":[{"role":"user","content":"hi"}]}')

        assert_equal(
          { 'type' => 'agent_response', 'content' => 'hi there', 'event_id' => 9, 'is_final' => false },
          next_message(messages),
        )
        assert_equal(
          { 'type' => 'agent_response', 'content' => '', 'event_id' => 9, 'is_final' => true },
          next_message(messages),
        )
      ensure
        io&.close
        reader&.kill
        server&.stop
        server_thread&.join(2)
      end

      private

      def next_message(queue)
        ::JSON.parse(Timeout.timeout(5) { queue.pop })
      end

      def wait_until(timeout: 5)
        deadline = Time.now + timeout
        sleep 0.01 until yield || Time.now > deadline
        raise 'condition not met in time' unless yield
      end
    end
  end
end
