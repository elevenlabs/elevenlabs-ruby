# frozen_string_literal: true

module Elevenlabs
  module Types
    module AgentAnalysisItemsInputEvaluationCriteriaItem
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :source
      member -> { ::Elevenlabs::Types::AttachedSystemEvaluationRef }, key: 'system'
      member -> { ::Elevenlabs::Types::AttachedUserEvaluationRef }, key: 'user'

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
