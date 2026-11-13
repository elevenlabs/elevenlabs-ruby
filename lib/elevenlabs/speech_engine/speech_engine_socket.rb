# frozen_string_literal: true

module Elevenlabs
  module SpeechEngine
    # A WebSocket connection to the `speech_engine` channel (`/speech-engine/upstream`).
    #
    # Received messages queue for `#recv` and `#each` until `#start_listening` hands them to the
    # handlers registered with `#on`.
    class SpeechEngineSocket
      include ::Elevenlabs::Internal::WebSocket::Channel

      RECEIVE_TYPES = [
        [::Elevenlabs::Types::UserTranscript, { 'type' => 'user_transcript' }, %w[event_id user_transcript]],
        [::Elevenlabs::Types::Init, { 'type' => 'init' }, ['conversation_id']],
        [::Elevenlabs::Types::SpeechEngineError, { 'type' => 'error' }, ['message']],
        [::Elevenlabs::Types::Ping, { 'type' => 'ping' }, []],
        [::Elevenlabs::Types::Close, { 'type' => 'close' }, []],
      ].freeze

      UNION_TYPES = [::Elevenlabs::Types::ReceiveUpstreamMessage].freeze

      # Sends a `sendUpstreamMessage` message.
      #
      # @param message [::Elevenlabs::Types::SendUpstreamMessage]
      # @raise [::Elevenlabs::Errors::WebSocketError] The connection is not open.
      # @return [void]
      def send_publish(message)
        send_json(message)
      end

      private

      def decode(text)
        data = parse_json(text)
        return [:raw, text] if data.equal?(NOT_JSON)

        match_json(data, RECEIVE_TYPES, UNION_TYPES) || [:unknown, data]
      end
    end
  end
end
