# frozen_string_literal: true

module Elevenlabs
  module Types
    class CustomSipHeader < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::CustomSipHeaderType }, optional: true, nullable: false
      field :key, -> { String }, optional: false, nullable: false
      field :value, -> { String }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(key, 'key', min_length: 1, max_length: 64, pattern: /^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$/)
        ::Elevenlabs::Validator.validate_string!(value, 'value', min_length: 1, max_length: 512, pattern: /^[\x09\x20-\x7E]+$/)
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
