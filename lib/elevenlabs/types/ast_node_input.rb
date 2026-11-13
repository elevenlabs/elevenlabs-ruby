# frozen_string_literal: true

module Elevenlabs
  module Types
    module AstNodeInput
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::AstAdditionOperatorNodeInput }, key: 'add_operator'
      member -> { ::Elevenlabs::Types::AstAndOperatorNodeInput }, key: 'and_operator'
      member -> { ::Elevenlabs::Types::AstBooleanNodeInput }, key: 'boolean_literal'
      member -> { ::Elevenlabs::Types::AstConditionalOperatorNodeInput }, key: 'conditional_operator'
      member -> { ::Elevenlabs::Types::AstDivisionOperatorNodeInput }, key: 'div_operator'
      member -> { ::Elevenlabs::Types::AstDynamicVariableNodeInput }, key: 'dynamic_variable'
      member -> { ::Elevenlabs::Types::AstEqualsOperatorNodeInput }, key: 'eq_operator'
      member -> { ::Elevenlabs::Types::AstGreaterThanOperatorNodeInput }, key: 'gt_operator'
      member -> { ::Elevenlabs::Types::AstGreaterThanOrEqualsOperatorNodeInput }, key: 'gte_operator'
      member -> { ::Elevenlabs::Types::AstLessThanOperatorNodeInput }, key: 'lt_operator'
      member -> { ::Elevenlabs::Types::AstLessThanOrEqualsOperatorNodeInput }, key: 'lte_operator'
      member -> { ::Elevenlabs::Types::AstMultiplicationOperatorNodeInput }, key: 'mul_operator'
      member -> { ::Elevenlabs::Types::AstNotEqualsOperatorNodeInput }, key: 'neq_operator'
      member -> { ::Elevenlabs::Types::AstNullNodeInput }, key: 'null_literal'
      member -> { ::Elevenlabs::Types::AstNumberNodeInput }, key: 'number_literal'
      member -> { ::Elevenlabs::Types::AstOrOperatorNodeInput }, key: 'or_operator'
      member -> { ::Elevenlabs::Types::AstStringNodeInput }, key: 'string_literal'
      member -> { ::Elevenlabs::Types::AstSubtractionOperatorNodeInput }, key: 'sub_operator'

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
