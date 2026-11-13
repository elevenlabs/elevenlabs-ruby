# frozen_string_literal: true

module Elevenlabs
  module Types
    class ElevenFlashV25VoiceSettings < ::Elevenlabs::Internal::Types::Model
      field :stability, -> { Float }, optional: true, nullable: true
      field :similarity_boost, -> { Float }, optional: true, nullable: true
      field :speed, -> { Float }, optional: true, nullable: true

      def validate!
        Validator.validate_number!(stability, 'stability', min: 0, max: 1)
        Validator.validate_number!(similarity_boost, 'similarity_boost', min: 0, max: 1)
        Validator.validate_number!(speed, 'speed', min: 0.7, max: 1.2)
      end

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
