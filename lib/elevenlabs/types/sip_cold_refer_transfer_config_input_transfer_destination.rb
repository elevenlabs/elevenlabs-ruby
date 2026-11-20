# frozen_string_literal: true

module Elevenlabs
  module Types
    module SipColdReferTransferConfigInputTransferDestination
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::PhoneDestinationInput }, key: 'phone'
      member -> { ::Elevenlabs::Types::PhoneDynamicVariableDestinationInput }, key: 'phone_dynamic_variable'
      member -> { ::Elevenlabs::Types::SipURIDestinationInput }, key: 'sip_uri'
      member -> { ::Elevenlabs::Types::SipURIDynamicVariableDestinationInput }, key: 'sip_uri_dynamic_variable'

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
