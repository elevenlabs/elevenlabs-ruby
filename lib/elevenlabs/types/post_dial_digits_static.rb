# frozen_string_literal: true

module Elevenlabs
  module Types
    class PostDialDigitsStatic < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::PostDialDigitsStaticType }, optional: true, nullable: false
      field :value, -> { String }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(value, 'value', min_length: 1, pattern: /^[0-9*#wW]*$/)
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
