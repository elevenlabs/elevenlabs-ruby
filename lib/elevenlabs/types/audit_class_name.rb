# frozen_string_literal: true

module Elevenlabs
  module Types
    module AuditClassName
      extend ::Elevenlabs::Internal::Types::Enum

      ACCOUNT_CHANGE = :'Account Change'
      AUTHENTICATION = :Authentication
      ENTITY_MANAGEMENT = :'Entity Management'
      USER_ACCESS_MANAGEMENT = :'User Access Management'
      GROUP_MANAGEMENT = :'Group Management'

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
