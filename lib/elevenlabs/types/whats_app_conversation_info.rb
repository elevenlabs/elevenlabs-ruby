# frozen_string_literal: true

module Elevenlabs
  module Types
    class WhatsAppConversationInfo < ::Elevenlabs::Internal::Types::Model
      field :direction, -> { ::Elevenlabs::Types::WhatsAppConversationInfoDirection }, optional: true, nullable: false
      field :whatsapp_phone_number_id, -> { String }, optional: true, nullable: true
      field :whatsapp_user_id, -> { String }, optional: false, nullable: false
      field :awaiting_first_user_message, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :recipient, -> { ::Elevenlabs::Types::WhatsAppRecipient }, optional: true, nullable: true
      field :call_permission_request, -> { ::Elevenlabs::Types::WhatsAppCallPermissionRequest }, optional: true, nullable: true
      field :call_result, -> { ::Elevenlabs::Types::CallResult }, optional: true, nullable: false
      field :opening_message, -> { ::Elevenlabs::Types::WhatsAppOpeningMessage }, optional: true, nullable: true

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
