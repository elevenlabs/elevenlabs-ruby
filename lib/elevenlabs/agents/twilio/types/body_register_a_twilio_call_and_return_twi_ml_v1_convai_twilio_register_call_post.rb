# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Twilio
      module Types
        class BodyRegisterATwilioCallAndReturnTwiMlV1ConvaiTwilioRegisterCallPost < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false
          field :from_number, -> { String }, optional: false, nullable: false
          field :to_number, -> { String }, optional: false, nullable: false
          field :direction, -> { ::Elevenlabs::Types::TelephonyDirection }, optional: true, nullable: false
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
