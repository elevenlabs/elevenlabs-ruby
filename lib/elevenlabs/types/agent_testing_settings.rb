# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentTestingSettings < ::Elevenlabs::Internal::Types::Model
      field :attached_tests, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AttachedTestModel] }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(attached_tests, 'attached_tests', min_items: 0, max_items: 5000)
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
