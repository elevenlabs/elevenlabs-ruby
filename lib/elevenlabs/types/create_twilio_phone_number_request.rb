# frozen_string_literal: true

module Elevenlabs
  module Types
    class CreateTwilioPhoneNumberRequest < ::Elevenlabs::Internal::Types::Model
      field :phone_number, -> { String }, optional: false, nullable: false
      field :label, -> { String }, optional: false, nullable: false
      field :supports_inbound, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :supports_outbound, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :provider, -> { ::Elevenlabs::Types::CreateTwilioPhoneNumberRequestProvider }, optional: true, nullable: false
      field :agent_id, -> { String }, optional: true, nullable: true
      field :sid, -> { String }, optional: false, nullable: false
      field :token, -> { String }, optional: false, nullable: false
      field :account_auth_token, -> { String }, optional: true, nullable: true
      field :region_config, -> { ::Elevenlabs::Types::RegionConfigRequest }, optional: true, nullable: true
      field :enable_sms, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
