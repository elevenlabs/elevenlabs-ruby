# frozen_string_literal: true

module Elevenlabs
  module Types
    class CreateSimulationTestRequest < ::Elevenlabs::Internal::Types::Model
      field :from_conversation_metadata, -> { ::Elevenlabs::Types::TestFromConversationMetadataInput }, optional: true, nullable: false
      field :dynamic_variables, -> { Object }, optional: true, nullable: false
      field :chat_history, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationHistoryTranscriptCommonModelInput] }, optional: true, nullable: false
      field :conversation_initiation_source, -> { ::Elevenlabs::Types::ConversationInitiationSource }, optional: true, nullable: false
      field :environment, -> { String }, optional: true, nullable: true
      field :type, -> { ::Elevenlabs::Types::CreateSimulationTestRequestType }, optional: true, nullable: false
      field :success_condition, -> { String }, optional: true, nullable: true
      field :success_conditions, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :simulation_scenario, -> { String }, optional: true, nullable: false
      field :simulation_max_turns, -> { Integer }, optional: true, nullable: false
      field :simulation_environment, -> { String }, optional: true, nullable: true
      field :tool_mock_config, -> { ::Elevenlabs::Types::SimulationToolMockBehaviorConfig }, optional: true, nullable: false
      field :tool_mock_overrides, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ToolResponseMockConfigInput]] }, optional: true, nullable: false
      field :evaluation_model, -> { ::Elevenlabs::Types::Llm }, optional: true, nullable: false
      field :simulated_user_model, -> { ::Elevenlabs::Types::Llm }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :parent_folder_id, -> { String }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_array!(chat_history, 'chat_history', max_items: 200)
        ::Elevenlabs::Validator.validate_array!(success_conditions, 'success_conditions', max_items: 30)
        ::Elevenlabs::Validator.validate_integer!(simulation_max_turns, 'simulation_max_turns', min: 1, max: 50)
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
