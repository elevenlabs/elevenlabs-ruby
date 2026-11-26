# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationAgentResponseAgentResponseEvent < ::Elevenlabs::Internal::Types::Model
      field :agent_response, -> { String }, optional: false, nullable: false
      field :event_id, -> { Integer }, optional: false, nullable: false
      field :response_id, -> { String }, optional: false, nullable: false
      field :in_response_to_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :response_type, -> { ::Elevenlabs::Types::ConversationAgentResponseAgentResponseEventResponseType }, optional: true, nullable: false
      field :attachments, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationAgentResponseAgentResponseEventAttachmentsItem] }, optional: true, nullable: false

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
