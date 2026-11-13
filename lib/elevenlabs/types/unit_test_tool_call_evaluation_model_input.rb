# frozen_string_literal: true

module Elevenlabs
  module Types
    class UnitTestToolCallEvaluationModelInput < ::Elevenlabs::Internal::Types::Model
      field :parameters, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::UnitTestToolCallParameter] }, optional: true, nullable: false
      field :referenced_tool, -> { ::Elevenlabs::Types::ReferencedToolCommonModel }, optional: true, nullable: true
      field :verify_absence, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :workflow_node_transition, -> { ::Elevenlabs::Types::UnitTestWorkflowNodeTransitionEvaluationNodeID }, optional: true, nullable: true
      field :guardrail_trigger, -> { ::Elevenlabs::Types::UnitTestGuardrailTriggerEvaluationModel }, optional: true, nullable: true

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
