# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowLlmConditionModelOutput < ::Elevenlabs::Internal::Types::Model
      field :label, -> { String }, optional: false, nullable: true
      field :type, -> { ::Elevenlabs::Types::WorkflowLlmConditionModelOutputType }, optional: false, nullable: false
      field :condition, -> { String }, optional: false, nullable: false

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
