# frozen_string_literal: true

module Elevenlabs
  module Types
    class OutboundCallRecipientResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :phone_number, -> { String }, optional: true, nullable: true
      field :whatsapp_user_id, -> { String }, optional: true, nullable: true
      field :status, -> { ::Elevenlabs::Types::BatchCallRecipientStatus }, optional: false, nullable: false
      field :created_at_unix, -> { Integer }, optional: false, nullable: false
      field :updated_at_unix, -> { Integer }, optional: false, nullable: false
      field :conversation_id, -> { String }, optional: false, nullable: true
      field :conversation_initiation_client_data, -> { ::Elevenlabs::Types::ConversationInitiationClientDataInternal }, optional: true, nullable: true

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
