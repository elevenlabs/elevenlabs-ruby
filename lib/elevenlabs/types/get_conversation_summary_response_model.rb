# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetConversationSummaryResponseModel < ::Elevenlabs::Internal::Types::Model
      field :conversation_id, -> { String }, optional: false, nullable: false
      field :agent_id, -> { String }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::GetConversationSummaryResponseModelStatus }, optional: false, nullable: false
      field :call_summary_title, -> { String }, optional: true, nullable: true
      field :transcript_summary, -> { String }, optional: true, nullable: true
      field :call_successful, -> { ::Elevenlabs::Types::EvaluationSuccessResult }, optional: true, nullable: false
      field :message_count, -> { Integer }, optional: false, nullable: false
      field :messages, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationSummaryMessageModel] }, optional: true, nullable: true
      field :messages_omitted, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :note, -> { String }, optional: false, nullable: false

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
