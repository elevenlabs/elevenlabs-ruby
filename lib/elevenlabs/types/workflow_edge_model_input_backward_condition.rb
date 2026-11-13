# frozen_string_literal: true

module Elevenlabs
  module Types
    module WorkflowEdgeModelInputBackwardCondition
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::WorkflowExpressionConditionModelInput }, key: 'expression'
      member -> { ::Elevenlabs::Types::WorkflowLlmConditionModelInput }, key: 'llm'
      member -> { ::Elevenlabs::Types::WorkflowResultConditionModelInput }, key: 'result'
      member -> { ::Elevenlabs::Types::WorkflowUnconditionalModelInput }, key: 'unconditional'

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
