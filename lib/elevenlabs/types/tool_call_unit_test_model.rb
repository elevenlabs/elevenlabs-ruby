# frozen_string_literal: true

module Elevenlabs
  module Types
    class ToolCallUnitTestModel < ::Elevenlabs::Internal::Types::Model
      field :from_conversation_metadata, -> { ::Elevenlabs::Types::TestFromConversationMetadataOutput }, optional: true, nullable: false
      field :dynamic_variables, -> { Object }, optional: true, nullable: false
      field :chat_history, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationHistoryTranscriptCommonModelOutput] }, optional: true, nullable: false
      field :conversation_initiation_source, -> { ::Elevenlabs::Types::ConversationInitiationSource }, optional: true, nullable: false
      field :environment, -> { String }, optional: true, nullable: true
      field :type, -> { ::Elevenlabs::Types::ToolCallUnitTestModelType }, optional: true, nullable: false
      field :tool_call_parameters, -> { ::Elevenlabs::Types::UnitTestToolCallEvaluationModelOutput }, optional: true, nullable: false
      field :check_any_tool_matches, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_array!(chat_history, 'chat_history', max_items: 200)
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
