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

      # A stream whose #each blocks on +blocker+ partway through, so the test can
      # hold the transcript worker mid-response and prove the reader is still free.
      class BlockingStream
        include Enumerable

        def initialize(started, blocker)
          @started = started
          @blocker = blocker
        end

        def each
          yield 'first '
          @started << true
          @blocker.pop
          yield 'second'
        end
      end

      # rubocop:disable Minitest/MultipleAssertions
      def test_ping_is_answered_while_a_slow_transcript_stream_runs
        started = Thread::Queue.new
        blocker = Thread::Queue.new
        stream = BlockingStream.new(started, blocker)
        server = Server.new(
          port: 0,
          api_key: API_KEY,
          handlers: { on_transcript: ->(_transcript, session) { session.send_response(stream) } },
        )
        server_thread = Thread.new { server.serve }
        wait_until { server.bound_port }
        io, messages, client, reader = open_client(server)

        client.text('{"type":"user_transcript","event_id":4,"user_transcript":[]}')

        assert_equal(
          { 'type' => 'agent_response', 'content' => 'first ', 'event_id' => 4, 'is_final' => false },
          next_message(messages),
        )
        Timeout.timeout(5) { started.pop } # the worker is now blocked mid-stream

        # The reader thread must still answer a ping while the worker is blocked.
        client.text('{"type":"ping"}')

        assert_equal({ 'type' => 'pong' }, next_message(messages))

        blocker << true # let the stream finish

        assert_equal(
          { 'type' => 'agent_response', 'content' => 'second', 'event_id' => 4, 'is_final' => false },
          next_message(messages),
        )
        assert_equal(
          { 'type' => 'agent_response', 'content' => '', 'event_id' => 4, 'is_final' => true },
          next_message(messages),
        )
      ensure
        blocker << true # avoid wedging the worker if an assertion failed first
        io&.close
        reader&.kill
        server&.stop
        server_thread&.join(2)
      end
      # rubocop:enable Minitest/MultipleAssertions

      def test_serve_returns_without_error_when_stopped
        server = Server.new(port: 0, api_key: API_KEY)
        server_thread = Thread.new { server.serve }
        wait_until { server.bound_port }

        server.stop

        # Thread#join re-raises any unhandled exception from serve (e.g. the NoMethodError from
        # reading a nil'd @tcp_server), so this fails if stop crashes the accept loop.
        assert server_thread.join(5), 'serve should return cleanly after stop'
      ensure
        server&.stop
        server_thread&.join(2)
      end

      def test_close_handshake_timeout_releases_the_connection
        server = Server.new(
          port: 0,
          api_key: API_KEY,
          close_handshake_timeout: 0.3,
          handlers: { on_transcript: ->(_transcript, session) { session.close } },
        )
        server_thread = Thread.new { server.serve }
        wait_until { server.bound_port }
        io, _messages, client, reader = open_client(server)

        # The handler closes the session (the server sends a WebSocket close frame). Kill the client
        # reader so it never acknowledges, leaving the close handshake incomplete.
        reader.kill
        client.text('{"type":"user_transcript","event_id":1,"user_transcript":[]}')

        # With no acknowledgement the server must force-close and release the connection slot within
        # the close-handshake timeout rather than looping forever.
        connections = server.instance_variable_get(:@connections)
        wait_until(timeout: 5) { connections.empty? }
      ensure
        io&.close
        reader&.kill
        server&.stop
        server_thread&.join(2)
      end

      def test_stop_closes_active_connections
        server = Server.new(port: 0, api_key: API_KEY)
        server_thread = Thread.new { server.serve }
        wait_until { server.bound_port }
        io, _messages, _client, reader = open_client(server)

        server.stop

        assert reader.join(5), 'client reader should exit once the server drains the connection'
      ensure
        io&.close
        reader&.kill
        server&.stop
        server_thread&.join(2)
      end

      def test_connection_that_never_handshakes_is_dropped
        server = Server.new(port: 0, api_key: API_KEY, handshake_timeout: 0.3)
        server_thread = Thread.new { server.serve }
        wait_until { server.bound_port }
        io = TCPSocket.new('127.0.0.1', server.bound_port)

        assert socket_closed?(io), 'server should drop a connection that never completes the handshake'
      ensure
        io&.close
        server&.stop
        server_thread&.join(2)
      end

      def test_connections_beyond_the_cap_are_refused
        server = Server.new(port: 0, api_key: API_KEY, max_connections: 1)
        server_thread = Thread.new { server.serve }
        wait_until { server.bound_port }
        io1, _messages, _client, reader1 = open_client(server) # fills the only slot

        io2 = TCPSocket.new('127.0.0.1', server.bound_port)

        assert socket_closed?(io2), 'a connection beyond the cap should be closed immediately'
      ensure
        io1&.close
        io2&.close
        reader1&.kill
        server&.stop
        server_thread&.join(2)
      end

      private

      # Connect a websocket-driver client, complete the handshake, and return
      # [io, messages_queue, client, reader_thread].
      def open_client(server)
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
        [io, messages, client, reader]
      end

      # Whether the peer closes +io+ within the timeout (EOF or a reset).
      def socket_closed?(io, timeout: 5)
        Timeout.timeout(timeout) do
          io.readpartial(4096)
          false
        end
      rescue IOError, Errno::ECONNRESET # EOFError is a subclass of IOError
        true
      rescue Timeout::Error
        false
      end

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
