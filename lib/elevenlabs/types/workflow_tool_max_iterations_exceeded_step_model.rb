# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowToolMaxIterationsExceededStepModel < ::Elevenlabs::Internal::Types::Model
      field :step_latency_secs, -> { Float }, optional: false, nullable: false
      field :type, -> { ::Elevenlabs::Types::WorkflowToolMaxIterationsExceededStepModelType }, optional: true, nullable: false
      field :max_iterations, -> { Integer }, optional: false, nullable: false

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
