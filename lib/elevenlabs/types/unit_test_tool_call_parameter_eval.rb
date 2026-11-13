# frozen_string_literal: true

module Elevenlabs
  module Types
    module UnitTestToolCallParameterEval
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::MatchAnythingParameterEvaluationStrategy }, key: 'anything'
      member -> { ::Elevenlabs::Types::ExactParameterEvaluationStrategy }, key: 'exact'
      member -> { ::Elevenlabs::Types::LlmParameterEvaluationStrategy }, key: 'llm'
      member -> { ::Elevenlabs::Types::RegexParameterEvaluationStrategy }, key: 'regex'

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
