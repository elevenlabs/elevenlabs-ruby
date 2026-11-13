# frozen_string_literal: true

module Elevenlabs
  module Types
    class SubmitCampaignRecipient < ::Elevenlabs::Internal::Types::Model
      field :phone_number, -> { String }, optional: true, nullable: true
      field :phone_numbers, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :whatsapp_user_id, -> { String }, optional: true, nullable: true
      field :id, -> { String }, optional: true, nullable: true
      field :conversation_initiation_client_data, -> { ::Elevenlabs::Types::ConversationInitiationClientDataRequestInput }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(phone_number, 'phone_number', max_length: 64)
        ::Elevenlabs::Validator.validate_array!(phone_numbers, 'phone_numbers', max_items: 5)
        ::Elevenlabs::Validator.validate_string!(whatsapp_user_id, 'whatsapp_user_id', max_length: 256)
        ::Elevenlabs::Validator.validate_string!(id, 'id', max_length: 256)
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
