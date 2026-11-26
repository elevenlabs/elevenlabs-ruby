# frozen_string_literal: true

module Elevenlabs
  module Types
    module ReceiveSubtitlingStreamMessage
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :message_type
      member -> { ::Elevenlabs::Types::SubtitlingSessionStarted }, key: 'session_started'
      member -> { ::Elevenlabs::Types::SubtitlingStatus }, key: 'status'
      member -> { ::Elevenlabs::Types::SubtitlingPartialTranscript }, key: 'partial_transcript'
      member -> { ::Elevenlabs::Types::SubtitlingFinalTranscript }, key: 'final_transcript'
      member -> { ::Elevenlabs::Types::SubtitlingPartialSubtitle }, key: 'partial_subtitle'
      member -> { ::Elevenlabs::Types::SubtitlingCommittedSubtitle }, key: 'committed_subtitle'
      member -> { ::Elevenlabs::Types::SubtitlingError }, key: 'error'
      member -> { ::Elevenlabs::Types::SubtitlingAuthError }, key: 'auth_error'
      member -> { ::Elevenlabs::Types::SubtitlingRateLimitedError }, key: 'rate_limited'
      member -> { ::Elevenlabs::Types::SubtitlingQueueOverflowError }, key: 'queue_overflow'
      member -> { ::Elevenlabs::Types::SubtitlingInputError }, key: 'input_error'
      member -> { ::Elevenlabs::Types::SubtitlingTranscriberError }, key: 'transcriber_error'
      member -> { ::Elevenlabs::Types::SubtitlingTranslationError }, key: 'translation_error'
      member -> { ::Elevenlabs::Types::SubtitlingQuotaExceededError }, key: 'quota_exceeded'
      member -> { ::Elevenlabs::Types::SubtitlingPaymentIssueError }, key: 'payment_issue'
      member -> { ::Elevenlabs::Types::SubtitlingUnacceptedTermsError }, key: 'unaccepted_terms'

      def self.load(str)
        coerce(::JSON.parse(str, symbolize_names: true))
      end

      def self.dump(value)
        coerced = coerce(value)
        ::JSON.generate(coerced.nil? || !coerced.respond_to?(:to_h) ? coerced : coerced.to_h)
      end
    end
  end
end
