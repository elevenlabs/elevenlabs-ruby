# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Whatsapp
      module Types
        class BodyMakeAnOutboundCallViaWhatsAppV1ConvaiWhatsappOutboundCallPost < ::Elevenlabs::Internal::Types::Model
          field :whatsapp_phone_number_id, -> { String }, optional: false, nullable: false
          field :whatsapp_user_id, -> { String }, optional: false, nullable: false
          field :whatsapp_call_permission_request_template_name, -> { String }, optional: false, nullable: false
          field :whatsapp_call_permission_request_template_language_code, -> { String }, optional: false, nullable: false
          field :agent_id, -> { String }, optional: false, nullable: false
          field :conversation_initiation_client_data, -> { ::Elevenlabs::Types::ConversationInitiationClientDataRequestInput }, optional: true, nullable: false

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
  end
end
