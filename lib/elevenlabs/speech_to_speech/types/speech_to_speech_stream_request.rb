# frozen_string_literal: true

module Elevenlabs
  module SpeechToSpeech
    module Types
      class SpeechToSpeechStreamRequest < ::Elevenlabs::Internal::Types::Model
        field :audio, -> { String }, optional: false, nullable: false
        field :model_id, -> { String }, optional: true, nullable: false
        field :voice_settings, -> { String }, optional: true, nullable: true
        field :seed, -> { Integer }, optional: true, nullable: true
        field :remove_background_noise, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :file_format, -> { ::Elevenlabs::SpeechToSpeech::Types::SpeechToSpeechStreamRequestFileFormat }, optional: true, nullable: true

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
