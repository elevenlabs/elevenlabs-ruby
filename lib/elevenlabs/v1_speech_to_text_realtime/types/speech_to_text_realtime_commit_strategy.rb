# frozen_string_literal: true

module Elevenlabs
  module V1SpeechToTextRealtime
    module Types
      module SpeechToTextRealtimeCommitStrategy
        extend ::Elevenlabs::Internal::Types::Enum

        MANUAL = :manual
        VAD = :vad
        TURN_PREDICTION = :turn_prediction

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
