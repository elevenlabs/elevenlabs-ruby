# frozen_string_literal: true

require 'json'
require_relative 'conversation_message'

module Elevenlabs
  module SpeechEngine
    # One Speech Engine conversation over a single WebSocket connection.
    #
    # The session is transport-agnostic: it is handed a +send+ callable that writes
    # a text frame and a +close+ callable that closes the connection, so the same
    # protocol logic drives the bundled {Server} and any custom integration. Feed
    # inbound frames to {#handle_raw_message}; register handlers with {#on}.
    #
    # Hand-written (see +.fernignore+), mirroring +SpeechEngineSession+ in the
    # PHP/Python/TS SDKs. Each handler is called with its event arguments followed
    # by this session as the last argument. Events:
    #
    # - +init+ — +(conversation_id, session)+
    # - +user_transcript+ — +(Array<ConversationMessage> transcript, session)+
    # - +close+ — +(session)+
    # - +disconnected+ — +(session)+
    # - +error+ — +(error, session)+
    class Session
      # @param send [#call] Writes a text frame to the connection.
      # @param close [#call, nil] Closes the connection. No-op if omitted.
      # @param debug [Boolean] When true, logs protocol activity to $stderr.
      def initialize(send:, close: nil, debug: false)
        @send = send
        @close_connection = close || -> {}
        @debug = debug
        @handlers = Hash.new { |h, k| h[k] = [] }
        @conversation_id = nil
        @current_event_id = nil
        @in_transcript_handler = false
        @closed = false
      end

      # Register a handler for an event. Accepts a callable or a block. Returns
      # self for chaining.
      def on(event, handler = nil, &block)
        callback = handler || block
        @handlers[event.to_s] << callback if callback
        self
      end

      # The conversation ID assigned by the API, available after the +init+ event.
      attr_reader :conversation_id

      # Whether the session is still open.
      def open?
        !@closed
      end

      # Parse and dispatch one inbound text frame. Malformed frames surface on the
      # +error+ event rather than raising, so one bad message never ends the loop.
      def handle_raw_message(raw)
        msg = ::JSON.parse(raw)
      rescue ::JSON::ParserError => e
        emit('error', e)
      else
        if msg.is_a?(::Hash)
          handle_message(msg)
        else
          emit('error', RuntimeError.new('Expected a JSON object message'))
        end
      end

      # Send an LLM response back for TTS synthesis. Accepts a plain string or an
      # enumerable of chunks (strings, or OpenAI/Anthropic/Gemini stream events —
      # text is auto-extracted). Only valid inside an +on('user_transcript')+
      # handler; called elsewhere it warns and does nothing.
      def send_response(response)
        raise 'Cannot send response: session is closed' if @closed

        unless @in_transcript_handler
          warn(
            "[SpeechEngine] send_response called outside an on('user_transcript') handler; " \
            'responses can only be sent in reply to a user transcript. To have the agent speak ' \
            'first, set a first message in your Speech Engine conversation config.',
          )
          return
        end

        event_id = @current_event_id
        if response.is_a?(String)
          send_agent_response(response, false, event_id)
          send_agent_response('', true, event_id)
          return
        end

        response.each do |chunk|
          break if @closed

          text = self.class.extract_text(chunk)
          send_agent_response(text, false, event_id) if text && !text.empty?
        end
        send_agent_response('', true, event_id) unless @closed
      end

      # Notify the session that the underlying connection dropped at the transport
      # level. Fires +disconnected+ once. Called by {Server}; not needed when
      # driving the session yourself through {#handle_raw_message}.
      def handle_disconnect
        return if @closed

        @closed = true
        emit('disconnected')
      end

      # Close the session and its underlying connection.
      def close
        return if @closed

        @closed = true
        @close_connection.call
      end

      # Extract text from one LLM stream chunk. Handles plain strings and the
      # common streaming shapes (as hashes with string or symbol keys): OpenAI
      # Responses (+response.output_text.delta+), OpenAI Chat Completions
      # (+choices[0].delta.content+), Anthropic (+content_block_delta+ /
      # +text_delta+), and Google Gemini (text parts of
      # +candidates[0].content.parts+).
      #
      # @api private
      def self.extract_text(chunk)
        return chunk if chunk.is_a?(String)
        return nil unless chunk.is_a?(::Hash)

        # OpenAI Responses API
        if dig_key(chunk, 'type') == 'response.output_text.delta'
          delta = dig_key(chunk, 'delta')
          return delta if delta.is_a?(String)
        end

        # OpenAI Chat Completions API
        choices = dig_key(chunk, 'choices')
        if choices.is_a?(::Array) && choices[0].is_a?(::Hash)
          delta = dig_key(choices[0], 'delta')
          content = delta.is_a?(::Hash) ? dig_key(delta, 'content') : nil
          return content if content.is_a?(String)
        end

        # Anthropic Messages API
        if dig_key(chunk, 'type') == 'content_block_delta'
          delta = dig_key(chunk, 'delta')
          if delta.is_a?(::Hash) && dig_key(delta, 'type') == 'text_delta'
            text = dig_key(delta, 'text')
            return text if text.is_a?(String)
          end
        end

        # Google Gemini API
        candidates = dig_key(chunk, 'candidates')
        if candidates.is_a?(::Array) && candidates[0].is_a?(::Hash)
          content = dig_key(candidates[0], 'content')
          parts = content.is_a?(::Hash) ? dig_key(content, 'parts') : nil
          if parts.is_a?(::Array)
            texts = parts.filter_map do |part|
              next unless part.is_a?(::Hash) && dig_key(part, 'thought') != true

              t = dig_key(part, 'text')
              t if t.is_a?(String)
            end
            return texts.join unless texts.empty?
          end
        end

        nil
      end

      # Read a key from a hash that may use string or symbol keys.
      #
      # @api private
      def self.dig_key(hash, key)
        hash.fetch(key) { hash[key.to_sym] }
      end

      private

      def handle_message(msg)
        case msg['type']
        when 'init'
          @conversation_id = msg['conversation_id'].is_a?(String) ? msg['conversation_id'] : nil
          log("session initialized, conversation_id=#{@conversation_id}")
          emit('init', @conversation_id)
        when 'user_transcript'
          @current_event_id = msg['event_id'].is_a?(Integer) ? msg['event_id'] : nil
          raw = msg['user_transcript']
          transcript = []
          if raw.is_a?(::Array)
            raw.each do |m|
              next unless m.is_a?(::Hash) && m['role'].is_a?(String) && m['content'].is_a?(String)

              transcript << ConversationMessage.new(m['role'], m['content'])
            end
          end
          @in_transcript_handler = true
          begin
            emit('user_transcript', transcript)
          ensure
            @in_transcript_handler = false
          end
        when 'ping'
          send_json({ 'type' => 'pong' })
        when 'close'
          @closed = true
          emit('close')
        when 'error'
          message = msg['message'].is_a?(String) ? msg['message'] : ''
          emit('error', RuntimeError.new(message))
          # Unknown types are ignored for forward compatibility.
        end
      end

      def send_agent_response(content, is_final, event_id)
        send_json({
                    'type' => 'agent_response',
                    'content' => content,
                    'event_id' => event_id,
                    'is_final' => is_final,
                  })
      end

      def send_json(msg)
        return if @closed

        begin
          @send.call(::JSON.generate(msg))
        rescue StandardError
          # Send failed — the connection is gone; the server loop detects it.
        end
      end

      def emit(event, *args)
        @handlers[event].each do |handler|
          handler.call(*args, self)
        rescue StandardError => e
          if event == 'error'
            warn("[SpeechEngine] unhandled error in error handler: #{e.message}")
          else
            emit('error', e)
          end
        end
      end

      def log(message)
        warn("[SpeechEngine] #{message}") if @debug
      end
    end
  end
end
