# frozen_string_literal: true

module Elevenlabs
  module Types
    class TestFromConversationMetadataOutput < ::Elevenlabs::Internal::Types::Model
      field :conversation_id, -> { String }, optional: false, nullable: false
      field :agent_id, -> { String }, optional: false, nullable: false
      field :branch_id, -> { String }, optional: true, nullable: true
      field :workflow_node_id, -> { String }, optional: true, nullable: true
      field :original_agent_reply, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationHistoryTranscriptCommonModelOutput] }, optional: true, nullable: false

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
