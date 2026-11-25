# frozen_string_literal: true

module Elevenlabs
  module Subtitling
    # A WebSocket connection to the `subtitling` channel (`/v1/subtitling/realtime`).
    #
    # Received messages queue for `#recv` and `#each` until `#start_listening` hands them to the
    # handlers registered with `#on`.
    class SubtitlingSocket
      include ::Elevenlabs::Internal::WebSocket::Channel

      RECEIVE_TYPES = [
        [::Elevenlabs::Types::SubtitlingCommittedSubtitle, { 'message_type' => 'committed_subtitle' }, %w[cue_index lines start_ms end_ms]],
        [::Elevenlabs::Types::SubtitlingPartialSubtitle, { 'message_type' => 'partial_subtitle' }, %w[cue_index lines start_ms]],
        [::Elevenlabs::Types::SubtitlingSessionStarted, { 'message_type' => 'session_started' }, ['session_id']],
        [::Elevenlabs::Types::SubtitlingStatus, { 'message_type' => 'status' }, ['status']],
        [::Elevenlabs::Types::SubtitlingPartialTranscript, { 'message_type' => 'partial_transcript' }, ['text']],
        [::Elevenlabs::Types::SubtitlingFinalTranscript, { 'message_type' => 'final_transcript' }, ['text']],
        [::Elevenlabs::Types::SubtitlingError, { 'message_type' => 'error' }, ['error']],
        [::Elevenlabs::Types::SubtitlingAuthError, { 'message_type' => 'auth_error' }, ['error']],
        [::Elevenlabs::Types::SubtitlingRateLimitedError, { 'message_type' => 'rate_limited' }, ['error']],
        [::Elevenlabs::Types::SubtitlingQueueOverflowError, { 'message_type' => 'queue_overflow' }, ['error']],
        [::Elevenlabs::Types::SubtitlingInputError, { 'message_type' => 'input_error' }, ['error']],
        [::Elevenlabs::Types::SubtitlingTranscriberError, { 'message_type' => 'transcriber_error' }, ['error']],
        [::Elevenlabs::Types::SubtitlingTranslationError, { 'message_type' => 'translation_error' }, ['error']],
        [::Elevenlabs::Types::SubtitlingQuotaExceededError, { 'message_type' => 'quota_exceeded' }, ['error']],
        [::Elevenlabs::Types::SubtitlingPaymentIssueError, { 'message_type' => 'payment_issue' }, ['error']],
        [::Elevenlabs::Types::SubtitlingUnacceptedTermsError, { 'message_type' => 'unaccepted_terms' }, ['error']],
      ].freeze

      UNION_TYPES = [::Elevenlabs::Types::ReceiveSubtitlingStreamMessage].freeze

      # Sends a `sendSubtitlingStreamMessage` message.
      #
      # @param message [::Elevenlabs::Types::SendSubtitlingStreamMessage]
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
