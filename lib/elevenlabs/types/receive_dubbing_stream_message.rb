# frozen_string_literal: true

module Elevenlabs
  module Types
    module ReceiveDubbingStreamMessage
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :message_type
      member -> { ::Elevenlabs::Types::DubbingSessionStarted }, key: 'session_started'
      member -> { ::Elevenlabs::Types::DubbingStatus }, key: 'status'
      member -> { ::Elevenlabs::Types::DubbingPartialTranscript }, key: 'partial_transcript'
      member -> { ::Elevenlabs::Types::DubbingCommittedTranscript }, key: 'committed_transcript'
      member -> { ::Elevenlabs::Types::DubbingTranslation }, key: 'translation'
      member -> { ::Elevenlabs::Types::DubbingAudio }, key: 'audio'
      member -> { ::Elevenlabs::Types::DubbingErrorPayload }, key: 'error'
      member -> { ::Elevenlabs::Types::DubbingAuthError }, key: 'auth_error'
      member -> { ::Elevenlabs::Types::DubbingRateLimitedError }, key: 'rate_limited'
      member -> { ::Elevenlabs::Types::DubbingQueueOverflowError }, key: 'queue_overflow'
      member -> { ::Elevenlabs::Types::DubbingInvalidRequestError }, key: 'invalid_request'
      member -> { ::Elevenlabs::Types::DubbingInputError }, key: 'input_error'
      member -> { ::Elevenlabs::Types::DubbingTranscriberError }, key: 'transcriber_error'
      member -> { ::Elevenlabs::Types::DubbingTranslationError }, key: 'translation_error'
      member -> { ::Elevenlabs::Types::DubbingAudioOutputError }, key: 'audio_output_error'

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
