# frozen_string_literal: true

module Elevenlabs
  module TextToSpeechMultiContext
    # A WebSocket connection to the `text_to_speech_multi_context` channel (`/v1/text-to-speech/{voice_id}/multi-stream-input`).
    #
    # Received messages queue for `#recv` and `#each` until `#start_listening` hands them to the
    # handlers registered with `#on`.
    class TextToSpeechMultiContextSocket
      include ::Elevenlabs::Internal::WebSocket::Channel

      RECEIVE_TYPES = [
        [::Elevenlabs::Types::FinalOutputMulti, { 'is_final' => true }, ['context_id']],
      ].freeze

      UNION_TYPES = [::Elevenlabs::Types::ReceiveMessageMulti].freeze

      # Sends a `sendMessageMulti` message.
      #
      # @param message [::Elevenlabs::Types::SendMessageMulti]
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
