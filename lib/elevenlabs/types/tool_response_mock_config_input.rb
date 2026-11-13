# frozen_string_literal: true

module Elevenlabs
  module Types
    class ToolResponseMockConfigInput < ::Elevenlabs::Internal::Types::Model
      field :parameter_conditions, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::UnitTestToolCallParameter] }, optional: true, nullable: false
      field :mock_result, -> { String }, optional: false, nullable: false
      field :is_error, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
