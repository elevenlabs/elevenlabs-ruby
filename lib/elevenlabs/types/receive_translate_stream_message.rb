# frozen_string_literal: true

module Elevenlabs
  module Types
    module ReceiveTranslateStreamMessage
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :message_type
      member -> { ::Elevenlabs::Types::TranslateSessionStarted }, key: 'session_started'
      member -> { ::Elevenlabs::Types::TranslateStatus }, key: 'status'
      member -> { ::Elevenlabs::Types::TranslatePartialTranscript }, key: 'partial_transcript'
      member -> { ::Elevenlabs::Types::TranslateFinalTranscript }, key: 'final_transcript'
      member -> { ::Elevenlabs::Types::TranslateTranslation }, key: 'translation'
      member -> { ::Elevenlabs::Types::TranslateAudio }, key: 'audio'
      member -> { ::Elevenlabs::Types::TranslateError }, key: 'error'
      member -> { ::Elevenlabs::Types::TranslateAuthError }, key: 'auth_error'
      member -> { ::Elevenlabs::Types::TranslateRateLimitedError }, key: 'rate_limited'
      member -> { ::Elevenlabs::Types::TranslateQueueOverflowError }, key: 'queue_overflow'
      member -> { ::Elevenlabs::Types::TranslateInputError }, key: 'input_error'
      member -> { ::Elevenlabs::Types::TranslateTranscriberError }, key: 'transcriber_error'
      member -> { ::Elevenlabs::Types::TranslateTranslationError }, key: 'translation_error'
      member -> { ::Elevenlabs::Types::TranslateAudioOutputError }, key: 'audio_output_error'
      member -> { ::Elevenlabs::Types::TranslateQuotaExceededError }, key: 'quota_exceeded'
      member -> { ::Elevenlabs::Types::TranslatePaymentIssueError }, key: 'payment_issue'
      member -> { ::Elevenlabs::Types::TranslateUnacceptedTermsError }, key: 'unaccepted_terms'

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
