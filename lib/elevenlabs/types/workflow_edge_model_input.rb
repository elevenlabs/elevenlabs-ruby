# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowEdgeModelInput < ::Elevenlabs::Internal::Types::Model
      field :source, -> { String }, optional: false, nullable: false
      field :target, -> { String }, optional: false, nullable: false
      field :forward_condition, -> { ::Elevenlabs::Types::WorkflowEdgeModelInputForwardCondition }, optional: true, nullable: true
      field :backward_condition, -> { ::Elevenlabs::Types::WorkflowEdgeModelInputBackwardCondition }, optional: true, nullable: true
      field :reroutes, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::PositionInput] }, optional: true, nullable: false

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
