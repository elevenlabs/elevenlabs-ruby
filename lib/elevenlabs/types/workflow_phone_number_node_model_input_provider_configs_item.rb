# frozen_string_literal: true

module Elevenlabs
  module Types
    module WorkflowPhoneNumberNodeModelInputProviderConfigsItem
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::ExotelTransferInput }, key: 'exotel'
      member -> { ::Elevenlabs::Types::SipTransferInput }, key: 'sip_trunk'
      member -> { ::Elevenlabs::Types::TwilioTransferInput }, key: 'twilio'

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
