# frozen_string_literal: true

module Elevenlabs
  module Types
    module ReceiveTranscription
      extend ::Elevenlabs::Internal::Types::Union

      member -> { ::Elevenlabs::Types::SessionStarted }
      member -> { ::Elevenlabs::Types::PartialTranscript }
      member -> { ::Elevenlabs::Types::CommittedTranscript }
      member -> { ::Elevenlabs::Types::DiarizedTranscript }
      member -> { ::Elevenlabs::Types::SpeakersMerged }
      member -> { ::Elevenlabs::Types::CommittedTranscriptWithTimestamps }
      member -> { ::Elevenlabs::Types::CommittedTranscriptEntities }
      member -> { ::Elevenlabs::Types::RedactedTranscript }
      member -> { ::Elevenlabs::Types::EditedTranscript }
      member -> { ::Elevenlabs::Types::ScribeWarning }
      member -> { ::Elevenlabs::Types::ScribeError }
      member -> { ::Elevenlabs::Types::ScribeAuthError }
      member -> { ::Elevenlabs::Types::ScribeQuotaExceededError }
      member -> { ::Elevenlabs::Types::ScribeThrottledError }
      member -> { ::Elevenlabs::Types::ScribeUnacceptedTermsError }
      member -> { ::Elevenlabs::Types::ScribeRateLimitedError }
      member -> { ::Elevenlabs::Types::ScribeQueueOverflowError }
      member -> { ::Elevenlabs::Types::ScribeResourceExhaustedError }
      member -> { ::Elevenlabs::Types::ScribeSessionTimeLimitExceededError }
      member -> { ::Elevenlabs::Types::ScribeInputError }
      member -> { ::Elevenlabs::Types::ScribeInvalidRequestError }
      member -> { ::Elevenlabs::Types::ScribeChunkSizeExceededError }
      member -> { ::Elevenlabs::Types::ScribeInsufficientAudioActivityError }
      member -> { ::Elevenlabs::Types::ScribeTranscriberError }

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
