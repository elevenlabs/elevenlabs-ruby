# frozen_string_literal: true

module Elevenlabs
  module Types
    class AstConditionalOperatorNodeInput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::AstConditionalOperatorNodeInputType }, optional: true, nullable: false
      field :condition, -> { ::Elevenlabs::Types::AstNodeInput }, optional: false, nullable: false
      field :true_expression, -> { ::Elevenlabs::Types::AstNodeInput }, optional: false, nullable: false, api_name: 'trueExpression'
      field :false_expression, -> { ::Elevenlabs::Types::AstNodeInput }, optional: false, nullable: false, api_name: 'falseExpression'

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
