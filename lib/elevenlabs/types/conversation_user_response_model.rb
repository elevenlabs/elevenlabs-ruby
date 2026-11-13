# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationUserResponseModel < ::Elevenlabs::Internal::Types::Model
      field :user_id, -> { String }, optional: false, nullable: false
      field :last_contact_unix_secs, -> { Integer }, optional: false, nullable: false
      field :first_contact_unix_secs, -> { Integer }, optional: false, nullable: false
      field :conversation_count, -> { Integer }, optional: false, nullable: false
      field :last_contact_agent_id, -> { String }, optional: true, nullable: true
      field :last_contact_conversation_id, -> { String }, optional: false, nullable: false
      field :last_contact_agent_name, -> { String }, optional: true, nullable: true
      field :sentiment, -> { ::Elevenlabs::Types::SentimentAggregate }, optional: false, nullable: false
      field :most_frustrated_conversations, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::FrustratedConversationRef] }, optional: true, nullable: false

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
