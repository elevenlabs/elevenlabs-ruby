# frozen_string_literal: true

module Elevenlabs
  module Types
    module WebhookEventType
      extend ::Elevenlabs::Internal::Types::Enum

      TRANSCRIPT = :transcript
      AUDIO = :audio
      CALL_INITIATION_FAILURE = :call_initiation_failure
      ANSWERING_MACHINE_DETECTION = :answering_machine_detection
      UNREDACTED_TRANSCRIPT = :unredacted_transcript
      UNREDACTED_AUDIO = :unredacted_audio

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
