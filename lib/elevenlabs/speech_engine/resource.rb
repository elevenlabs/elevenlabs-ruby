# frozen_string_literal: true

require_relative 'jwt_verifier'
require_relative 'server'
require_relative 'session'

module Elevenlabs
  module SpeechEngine
    # A handle to a Speech Engine instance, returned by +speech_engine.create+ /
    # +speech_engine.get+ once the root client is wired to return it.
    #
    # Use {#serve} to run a standalone WebSocket server for this engine, or
    # {#create_session} to drive a session over a connection you manage yourself.
    # {#verify_request} checks an inbound request's authorization header when you
    # handle the WebSocket upgrade.
    #
    # Hand-written (see +.fernignore+), mirroring +SpeechEngineResource+ in the
    # PHP/Python/TS SDKs.
    class Resource
      # @return [String] The speech engine ID.
      attr_reader :engine_id

      # @return [Object, nil] The full API response, or nil when constructed without an API call.
      attr_reader :config

      # @param engine_id [String] The speech engine ID.
      # @param api_key [String, nil] The account API key the engine was created with.
      # @param config [Object, nil] The full API response.
      def initialize(engine_id, api_key: nil, config: nil)
        @engine_id = engine_id
        @api_key = api_key
        @config = config
      end

      # Verify that an incoming request carries a valid Speech Engine authorization
      # JWT. Only needed when managing the WebSocket upgrade yourself; {#serve}
      # verifies automatically. Header names are matched case-insensitively, and a
      # value may be a string or an array of strings.
      #
      # @param headers [Hash] Request headers (name => value).
      # @return [Boolean]
      def verify_request(headers)
        return false if @api_key.nil? || @api_key.empty?

        value = nil
        headers.each do |name, v|
          next unless name.to_s.casecmp('X-ElevenLabs-Speech-Engine-Authorization').zero?

          value = v.is_a?(::Array) ? v[0] : v
          break
        end
        return false unless value.is_a?(String) && !value.empty?

        begin
          JwtVerifier.verify(value, @api_key)
          true
        rescue StandardError
          false
        end
      end

      # Start a standalone WebSocket server for this engine. Blocks until stopped.
      # Verification uses the engine's API key unless +disable_auth+ is set. Event
      # handlers are passed as callables; each is called with its event arguments
      # followed by the {Session}.
      def serve(port: 3001, path: nil, debug: false, disable_auth: false,
                on_init: nil, on_transcript: nil, on_close: nil, on_disconnect: nil, on_error: nil)
        handlers = {
          on_init: on_init,
          on_transcript: on_transcript,
          on_close: on_close,
          on_disconnect: on_disconnect,
          on_error: on_error,
        }.compact

        Server.new(
          port: port,
          path: path,
          api_key: @api_key,
          debug: debug,
          disable_auth: disable_auth,
          handlers: handlers,
        ).serve
      end

      # Create a session over a connection you manage yourself (any transport).
      #
      # @param send [#call] Writes a text frame to the connection.
      # @param close [#call, nil] Closes the connection.
      # @param debug [Boolean]
      # @return [Session]
      def create_session(send:, close: nil, debug: false)
        Session.new(send: send, close: close, debug: debug)
      end
    end
  end
end
