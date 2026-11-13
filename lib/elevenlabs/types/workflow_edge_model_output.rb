# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowEdgeModelOutput < ::Elevenlabs::Internal::Types::Model
      field :source, -> { String }, optional: false, nullable: false
      field :target, -> { String }, optional: false, nullable: false
      field :forward_condition, -> { ::Elevenlabs::Types::WorkflowEdgeModelOutputForwardCondition }, optional: false, nullable: true
      field :backward_condition, -> { ::Elevenlabs::Types::WorkflowEdgeModelOutputBackwardCondition }, optional: false, nullable: true
      field :reroutes, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::PositionOutput] }, optional: false, nullable: false

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
