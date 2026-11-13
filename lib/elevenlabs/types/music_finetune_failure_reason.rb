# frozen_string_literal: true

module Elevenlabs
  module Types
    module MusicFinetuneFailureReason
      extend ::Elevenlabs::Internal::Types::Enum

      AUDIO_PROCESSING_FAILED = :audio_processing_failed
      COPYRIGHT_VIOLATION = :copyright_violation
      TRAINING_FAILED = :training_failed

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
