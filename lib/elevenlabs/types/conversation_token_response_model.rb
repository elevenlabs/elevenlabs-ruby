# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationTokenResponseModel < ::Elevenlabs::Internal::Types::Model
      field :agent_id, -> { String }, optional: false, nullable: false
      field :conversation_token, -> { String }, optional: false, nullable: false
      field :expiration_time_unix_secs, -> { Integer }, optional: true, nullable: true
      field :conversation_id, -> { String }, optional: true, nullable: true
      field :purpose, -> { ::Elevenlabs::Types::ConversationTokenPurpose }, optional: false, nullable: false
      field :token_requester_user_id, -> { String }, optional: true, nullable: true

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
