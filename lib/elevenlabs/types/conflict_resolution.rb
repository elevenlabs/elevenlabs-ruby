# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConflictResolution < ::Elevenlabs::Internal::Types::Model
      field :conflict_id, -> { String }, optional: false, nullable: false
      field :choice, -> { ::Elevenlabs::Types::ConflictResolutionChoice }, optional: false, nullable: false
      field :custom_value, -> { String }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_string!(custom_value, 'custom_value', max_length: 1_000_000)
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
