# frozen_string_literal: true

module Elevenlabs
  module TextToDialogueMultiContext
    # A WebSocket connection to the `text_to_dialogue_multi_context` channel (`/v1/text-to-dialogue/multi-stream-input`).
    #
    # Received messages queue for `#recv` and `#each` until `#start_listening` hands them to the
    # handlers registered with `#on`.
    class TextToDialogueMultiContextSocket
      include ::Elevenlabs::Internal::WebSocket::Channel

      RECEIVE_TYPES = [
        [::Elevenlabs::Types::FinalMulti, { 'is_final' => true }, []],
      ].freeze

      UNION_TYPES = [::Elevenlabs::Types::ReceiveTextToDialogueWebsocketMessageMulti].freeze

      # Sends a `Text To Dialogue Multi Client Message` message.
      #
      # @param message [::Elevenlabs::Types::TextToDialogueMultiClientMessage, Hash]
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
