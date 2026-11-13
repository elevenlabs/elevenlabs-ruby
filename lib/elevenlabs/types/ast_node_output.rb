# frozen_string_literal: true

module Elevenlabs
  module Types
    module AstNodeOutput
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::AstAdditionOperatorNodeOutput }, key: 'add_operator'
      member -> { ::Elevenlabs::Types::AstAndOperatorNodeOutput }, key: 'and_operator'
      member -> { ::Elevenlabs::Types::AstBooleanNodeOutput }, key: 'boolean_literal'
      member -> { ::Elevenlabs::Types::AstConditionalOperatorNodeOutput }, key: 'conditional_operator'
      member -> { ::Elevenlabs::Types::AstDivisionOperatorNodeOutput }, key: 'div_operator'
      member -> { ::Elevenlabs::Types::AstDynamicVariableNodeOutput }, key: 'dynamic_variable'
      member -> { ::Elevenlabs::Types::AstEqualsOperatorNodeOutput }, key: 'eq_operator'
      member -> { ::Elevenlabs::Types::AstGreaterThanOperatorNodeOutput }, key: 'gt_operator'
      member -> { ::Elevenlabs::Types::AstGreaterThanOrEqualsOperatorNodeOutput }, key: 'gte_operator'
      member -> { ::Elevenlabs::Types::AstllmNodeOutput }, key: 'llm'
      member -> { ::Elevenlabs::Types::AstLessThanOperatorNodeOutput }, key: 'lt_operator'
      member -> { ::Elevenlabs::Types::AstLessThanOrEqualsOperatorNodeOutput }, key: 'lte_operator'
      member -> { ::Elevenlabs::Types::AstMultiplicationOperatorNodeOutput }, key: 'mul_operator'
      member -> { ::Elevenlabs::Types::AstNotEqualsOperatorNodeOutput }, key: 'neq_operator'
      member -> { ::Elevenlabs::Types::AstNullNodeOutput }, key: 'null_literal'
      member -> { ::Elevenlabs::Types::AstNumberNodeOutput }, key: 'number_literal'
      member -> { ::Elevenlabs::Types::AstOrOperatorNodeOutput }, key: 'or_operator'
      member -> { ::Elevenlabs::Types::AstStringNodeOutput }, key: 'string_literal'
      member -> { ::Elevenlabs::Types::AstSubtractionOperatorNodeOutput }, key: 'sub_operator'

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
