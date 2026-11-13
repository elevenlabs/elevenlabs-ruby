# frozen_string_literal: true

module Elevenlabs
  module Types
    class InternalSamplingConfigResponseModel < ::Elevenlabs::Internal::Types::Model
      field :focus, -> { Float }, optional: true, nullable: true
      field :similarity, -> { Float }, optional: true, nullable: true
      field :stability, -> { Float }, optional: true, nullable: true

      def validate!
        Validator.validate_number!(focus, 'focus', min: 0, max: 1)
        Validator.validate_number!(similarity, 'similarity', min: 0, max: 1)
        Validator.validate_number!(stability, 'stability', min: 0, max: 1)
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
