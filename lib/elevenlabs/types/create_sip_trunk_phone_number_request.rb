# frozen_string_literal: true

module Elevenlabs
  module Types
    class CreateSipTrunkPhoneNumberRequest < ::Elevenlabs::Internal::Types::Model
      field :phone_number, -> { String }, optional: false, nullable: false
      field :label, -> { String }, optional: false, nullable: false
      field :supports_inbound, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :supports_outbound, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :provider, -> { ::Elevenlabs::Types::CreateSipTrunkPhoneNumberRequestProvider }, optional: true, nullable: false
      field :agent_id, -> { String }, optional: true, nullable: true
      field :inbound_trunk_config, -> { ::Elevenlabs::Types::InboundSipTrunkConfigRequestModel }, optional: true, nullable: true
      field :outbound_trunk_config, -> { ::Elevenlabs::Types::OutboundSipTrunkConfigRequestModel }, optional: true, nullable: true

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
