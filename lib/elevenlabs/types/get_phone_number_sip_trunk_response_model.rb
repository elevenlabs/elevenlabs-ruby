# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetPhoneNumberSipTrunkResponseModel < ::Elevenlabs::Internal::Types::Model
      field :phone_number, -> { String }, optional: false, nullable: false
      field :label, -> { String }, optional: false, nullable: false
      field :supports_inbound, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :supports_outbound, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :phone_number_id, -> { String }, optional: false, nullable: false
      field :assigned_agent, -> { ::Elevenlabs::Types::PhoneNumberAgentInfo }, optional: true, nullable: false
      field :provider, -> { ::Elevenlabs::Types::GetPhoneNumberSipTrunkResponseModelProvider }, optional: true, nullable: false
      field :provider_config, -> { ::Elevenlabs::Types::GetPhoneNumberOutboundSipTrunkConfigResponseModel }, optional: true, nullable: true
      field :outbound_trunk, -> { ::Elevenlabs::Types::GetPhoneNumberOutboundSipTrunkConfigResponseModel }, optional: true, nullable: false
      field :inbound_trunk, -> { ::Elevenlabs::Types::GetPhoneNumberInboundSipTrunkConfigResponseModel }, optional: true, nullable: true
      field :livekit_stack, -> { ::Elevenlabs::Types::LivekitStackType }, optional: false, nullable: false
      field :store_sip_messages, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
