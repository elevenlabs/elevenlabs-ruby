# frozen_string_literal: true

module Elevenlabs
  module SpeechToSpeech
    module Types
      module SpeechToSpeechStreamRequestFileFormat
        extend ::Elevenlabs::Internal::Types::Enum

        PCM_S16LE_16 = :pcm_s16le_16
        OTHER = :other

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
