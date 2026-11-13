# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubbingLanguageResponseVoiceSettings < ::Elevenlabs::Internal::Types::Model
      field :cloning_strength, -> { Integer }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(cloning_strength, 'cloning_strength', min: 0, max: 10)
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
