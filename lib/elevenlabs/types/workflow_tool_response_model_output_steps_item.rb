# frozen_string_literal: true

module Elevenlabs
  module Types
    module WorkflowToolResponseModelOutputStepsItem
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::WorkflowToolEdgeStepModel }, key: 'edge'
      member -> { ::Elevenlabs::Types::WorkflowToolMaxIterationsExceededStepModel }, key: 'max_iterations_exceeded'
      member -> { ::Elevenlabs::Types::WorkflowToolNestedToolsStepModelOutput }, key: 'nested_tools'

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
