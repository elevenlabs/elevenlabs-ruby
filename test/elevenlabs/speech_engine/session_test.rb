# frozen_string_literal: true

require 'minitest/autorun'
require 'json'
require 'elevenlabs/speech_engine/session'

module Elevenlabs
  module SpeechEngine
    class SessionTest < Minitest::Test
      def setup
        @sent = []
        @closed = false
      end

      def session
        Session.new(
          send: ->(text) { @sent << text },
          close: -> { @closed = true },
        )
      end

      def decoded_sent
        @sent.map { |s| ::JSON.parse(s) }
      end

      def test_init_sets_conversation_id_and_emits
        s = session
        seen = nil
        s.on('init') { |id, _session| seen = id }

        s.handle_raw_message('{"type":"init","conversation_id":"conv_1"}')

        assert_equal 'conv_1', seen
        assert_equal 'conv_1', s.conversation_id
      end

      def test_ping_receives_pong
        s = session
        s.handle_raw_message('{"type":"ping"}')

        assert_equal [{ 'type' => 'pong' }], decoded_sent
      end

      # rubocop:disable Minitest/MultipleAssertions
      def test_transcript_delivers_messages_and_string_response
        s = session
        received = nil
        s.on('user_transcript') do |transcript, sess|
          received = transcript
          sess.send_response('hello there')
        end

        s.handle_raw_message('{"type":"user_transcript","event_id":7,"user_transcript":[{"role":"user","content":"hi"}]}')

        assert_instance_of Array, received
        assert_equal 1, received.length
        assert_instance_of ConversationMessage, received[0]
        assert_equal 'user', received[0].role
        assert_equal 'hi', received[0].content

        assert_equal [
          { 'type' => 'agent_response', 'content' => 'hello there', 'event_id' => 7, 'is_final' => false },
          { 'type' => 'agent_response', 'content' => '', 'event_id' => 7, 'is_final' => true },
        ], decoded_sent
      end
      # rubocop:enable Minitest/MultipleAssertions

      def test_streamed_response_sends_chunks_then_final
        s = session
        s.on('user_transcript') { |_t, sess| sess.send_response(['foo', '', 'bar']) } # empty chunk is skipped

        s.handle_raw_message('{"type":"user_transcript","event_id":3,"user_transcript":[]}')

        assert_equal [
          { 'type' => 'agent_response', 'content' => 'foo', 'event_id' => 3, 'is_final' => false },
          { 'type' => 'agent_response', 'content' => 'bar', 'event_id' => 3, 'is_final' => false },
          { 'type' => 'agent_response', 'content' => '', 'event_id' => 3, 'is_final' => true },
        ], decoded_sent
      end

      def test_streamed_response_extracts_openai_chat_chunks
        s = session
        s.on('user_transcript') do |_t, sess|
          sess.send_response([
                               { 'choices' => [{ 'delta' => { 'content' => 'Hel' } }] },
                               { 'choices' => [{ 'delta' => { 'content' => 'lo' } }] },
                             ])
        end

        s.handle_raw_message('{"type":"user_transcript","event_id":1,"user_transcript":[]}')

        contents = decoded_sent.map { |m| m['content'] }

        assert_equal(['Hel', 'lo', ''], contents)
      end

      # rubocop:disable Minitest/MultipleAssertions
      def test_extracts_anthropic_and_gemini_chunks
        assert_equal 'ant', Session.extract_text(
          'type' => 'content_block_delta', 'delta' => { 'type' => 'text_delta', 'text' => 'ant' },
        )
        assert_equal 'gem', Session.extract_text(
          'candidates' => [{ 'content' => { 'parts' => [{ 'text' => 'gem' }] } }],
        )
        assert_equal 'resp', Session.extract_text(
          'type' => 'response.output_text.delta', 'delta' => 'resp',
        )
        assert_nil Session.extract_text('candidates' => [{ 'content' => { 'parts' => [{ 'thought' => true, 'text' => 'x' }] } }])
      end
      # rubocop:enable Minitest/MultipleAssertions

      def test_send_response_outside_handler_is_suppressed
        s = session
        _out, err = capture_io { s.send_response('nope') }

        assert_empty @sent
        assert_includes err, 'outside an'
      end

      def test_close_message_emits_close_and_closes_session
        s = session
        closed_event = false
        s.on('close') { |_sess| closed_event = true }

        s.handle_raw_message('{"type":"close"}')

        assert closed_event
        refute_predicate s, :open?
      end

      def test_error_message_emits_error
        s = session
        err = nil
        s.on('error') { |e, _sess| err = e }

        s.handle_raw_message('{"type":"error","message":"boom"}')

        assert_kind_of Exception, err
        assert_equal 'boom', err.message
      end

      def test_malformed_json_emits_error
        s = session
        err = nil
        s.on('error') { |e, _sess| err = e }

        s.handle_raw_message('{not json')

        assert_kind_of Exception, err
      end

      def test_close_invokes_close_callback
        s = session

        assert_predicate s, :open?

        s.close

        assert @closed
        refute_predicate s, :open?
      end

      def test_transport_disconnect_emits_disconnected_once
        s = session
        count = 0
        s.on('disconnected') { |_sess| count += 1 }

        s.handle_disconnect
        s.handle_disconnect

        assert_equal 1, count
        refute_predicate s, :open?
      end
    end
  end
end
