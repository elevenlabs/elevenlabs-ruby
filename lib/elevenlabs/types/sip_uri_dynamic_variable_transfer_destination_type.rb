# frozen_string_literal: true

module Elevenlabs
  module Types
    module SipURIDynamicVariableTransferDestinationType
      extend ::Elevenlabs::Internal::Types::Enum

      SIP_URI_DYNAMIC_VARIABLE = :sip_uri_dynamic_variable

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
