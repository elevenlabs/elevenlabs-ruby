# frozen_string_literal: true

module Elevenlabs
  module Types
    class SimulationToolMockBehaviorConfig < ::Elevenlabs::Internal::Types::Model
      field :mocking_strategy, -> { ::Elevenlabs::Types::MockingStrategy }, optional: true, nullable: false
      field :fallback_strategy, -> { ::Elevenlabs::Types::MockNoMatchBehavior }, optional: true, nullable: false
      field :mocked_tool_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false

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
