# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetWhatsAppAccountResponse < ::Elevenlabs::Internal::Types::Model
      field :business_account_id, -> { String }, optional: false, nullable: false
      field :phone_number_id, -> { String }, optional: false, nullable: false
      field :business_account_name, -> { String }, optional: false, nullable: false
      field :phone_number_name, -> { String }, optional: false, nullable: false
      field :phone_number, -> { String }, optional: false, nullable: false
      field :account_type, -> { ::Elevenlabs::Types::WhatsAppAccountType }, optional: true, nullable: false
      field :assigned_agent_id, -> { String }, optional: true, nullable: true
      field :enable_messaging, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :enable_audio_message_response, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :enable_typing_indicator, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :assigned_agent_name, -> { String }, optional: false, nullable: true
      field :is_token_expired, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
