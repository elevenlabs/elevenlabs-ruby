# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Twilio
      module Types
        class BodyHandleAnOutboundCallViaTwilioV1ConvaiTwilioOutboundCallPost < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false
          field :agent_phone_number_id, -> { String }, optional: false, nullable: false
          field :to_number, -> { String }, optional: false, nullable: false
          field :conversation_initiation_client_data, -> { ::Elevenlabs::Types::ConversationInitiationClientDataRequestInput }, optional: true, nullable: true
          field :call_recording_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
          field :telephony_call_config, -> { ::Elevenlabs::Types::TelephonyCallConfigInput }, optional: true, nullable: false

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
