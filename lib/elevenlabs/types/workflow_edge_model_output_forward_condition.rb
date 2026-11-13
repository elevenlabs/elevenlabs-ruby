# frozen_string_literal: true

module Elevenlabs
  module Types
    module WorkflowEdgeModelOutputForwardCondition
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::WorkflowExpressionConditionModelOutput }, key: 'expression'
      member -> { ::Elevenlabs::Types::WorkflowLlmConditionModelOutput }, key: 'llm'
      member -> { ::Elevenlabs::Types::WorkflowResultConditionModelOutput }, key: 'result'
      member -> { ::Elevenlabs::Types::WorkflowUnconditionalModelOutput }, key: 'unconditional'

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
