# frozen_string_literal: true

module Elevenlabs
  module Types
    class BodySimulatesAConversationStreamV1ConvaiAgentsAgentIDSimulateConversationStreamPost < ::Elevenlabs::Internal::Types::Model
      field :simulation_specification, -> { ::Elevenlabs::Types::ConversationSimulationSpecification }, optional: false, nullable: false
      field :extra_evaluation_criteria, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::PromptEvaluationCriteria] }, optional: true, nullable: true
      field :new_turns_limit, -> { Integer }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(new_turns_limit, 'new_turns_limit', max: 100)
      end

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
