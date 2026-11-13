# frozen_string_literal: true

module Elevenlabs
  module Translation
    # A WebSocket connection to the `translation` channel (`/v1/translation/realtime`).
    #
    # Received messages queue for `#recv` and `#each` until `#start_listening` hands them to the
    # handlers registered with `#on`.
    class TranslationSocket
      include ::Elevenlabs::Internal::WebSocket::Channel

      RECEIVE_TYPES = [
        [::Elevenlabs::Types::TranslateAudio, { 'message_type' => 'audio' }, %w[data sample_rate]],
        [::Elevenlabs::Types::TranslateSessionStarted, { 'message_type' => 'session_started' }, ['session_id']],
        [::Elevenlabs::Types::TranslateStatus, { 'message_type' => 'status' }, ['status']],
        [::Elevenlabs::Types::TranslatePartialTranscript, { 'message_type' => 'partial_transcript' }, ['text']],
        [::Elevenlabs::Types::TranslateFinalTranscript, { 'message_type' => 'final_transcript' }, ['text']],
        [::Elevenlabs::Types::TranslateTranslation, { 'message_type' => 'translation' }, ['text']],
        [::Elevenlabs::Types::TranslateError, { 'message_type' => 'error' }, ['error']],
        [::Elevenlabs::Types::TranslateAuthError, { 'message_type' => 'auth_error' }, ['error']],
        [::Elevenlabs::Types::TranslateRateLimitedError, { 'message_type' => 'rate_limited' }, ['error']],
        [::Elevenlabs::Types::TranslateQueueOverflowError, { 'message_type' => 'queue_overflow' }, ['error']],
        [::Elevenlabs::Types::TranslateInputError, { 'message_type' => 'input_error' }, ['error']],
        [::Elevenlabs::Types::TranslateTranscriberError, { 'message_type' => 'transcriber_error' }, ['error']],
        [::Elevenlabs::Types::TranslateTranslationError, { 'message_type' => 'translation_error' }, ['error']],
        [::Elevenlabs::Types::TranslateAudioOutputError, { 'message_type' => 'audio_output_error' }, ['error']],
        [::Elevenlabs::Types::TranslateQuotaExceededError, { 'message_type' => 'quota_exceeded' }, ['error']],
        [::Elevenlabs::Types::TranslatePaymentIssueError, { 'message_type' => 'payment_issue' }, ['error']],
        [::Elevenlabs::Types::TranslateUnacceptedTermsError, { 'message_type' => 'unaccepted_terms' }, ['error']],
      ].freeze

      UNION_TYPES = [::Elevenlabs::Types::ReceiveTranslateStreamMessage].freeze

      # Sends a `sendTranslateStreamMessage` message.
      #
      # @param message [::Elevenlabs::Types::SendTranslateStreamMessage]
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
