# frozen_string_literal: true

module Elevenlabs
  module TextToVoice
    module Types
      module FineTuningResponseStateValue
        extend ::Elevenlabs::Internal::Types::Enum

        NOT_STARTED = :not_started
        QUEUED = :queued
        FINE_TUNING = :fine_tuning
        FINE_TUNED = :fine_tuned
        FAILED = :failed
        DELAYED = :delayed

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
end
