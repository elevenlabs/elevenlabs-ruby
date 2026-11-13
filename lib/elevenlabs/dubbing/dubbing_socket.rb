# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    # A WebSocket connection to the `dubbing` channel (`/v1/dubbing/live`).
    #
    # Received messages queue for `#recv` and `#each` until `#start_listening` hands them to the
    # handlers registered with `#on`.
    class DubbingSocket
      include ::Elevenlabs::Internal::WebSocket::Channel

      RECEIVE_TYPES = [
        [::Elevenlabs::Types::DubbingCommittedTranscript, { 'message_type' => 'committed_transcript' }, %w[text segment_id start_s end_s speaker_id]],
        [::Elevenlabs::Types::DubbingTranslation, { 'message_type' => 'translation' }, %w[text segment_id start_s end_s speaker_id]],
        [::Elevenlabs::Types::DubbingAudio, { 'message_type' => 'audio' }, %w[data sample_rate]],
        [::Elevenlabs::Types::DubbingSessionStarted, { 'message_type' => 'session_started' }, ['session_id']],
        [::Elevenlabs::Types::DubbingStatus, { 'message_type' => 'status' }, ['status']],
        [::Elevenlabs::Types::DubbingPartialTranscript, { 'message_type' => 'partial_transcript' }, ['text']],
        [::Elevenlabs::Types::DubbingErrorPayload, { 'message_type' => 'error' }, ['error']],
        [::Elevenlabs::Types::DubbingAuthError, { 'message_type' => 'auth_error' }, ['error']],
        [::Elevenlabs::Types::DubbingRateLimitedError, { 'message_type' => 'rate_limited' }, ['error']],
        [::Elevenlabs::Types::DubbingQueueOverflowError, { 'message_type' => 'queue_overflow' }, ['error']],
        [::Elevenlabs::Types::DubbingInvalidRequestError, { 'message_type' => 'invalid_request' }, ['error']],
        [::Elevenlabs::Types::DubbingInputError, { 'message_type' => 'input_error' }, ['error']],
        [::Elevenlabs::Types::DubbingTranscriberError, { 'message_type' => 'transcriber_error' }, ['error']],
        [::Elevenlabs::Types::DubbingTranslationError, { 'message_type' => 'translation_error' }, ['error']],
        [::Elevenlabs::Types::DubbingAudioOutputError, { 'message_type' => 'audio_output_error' }, ['error']],
      ].freeze

      UNION_TYPES = [::Elevenlabs::Types::ReceiveDubbingStreamMessage].freeze

      # Sends a `sendDubbingStreamMessage` message.
      #
      # @param message [::Elevenlabs::Types::SendDubbingStreamMessage]
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
