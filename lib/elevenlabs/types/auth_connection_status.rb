# frozen_string_literal: true

module Elevenlabs
  module Types
    module AuthConnectionStatus
      extend ::Elevenlabs::Internal::Types::Enum

      ACTIVE = :active
      REFRESH_FAILED = :refresh_failed
      REVOKED = :revoked
      CREDENTIAL_INVALID = :credential_invalid

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
