# frozen_string_literal: true

module Elevenlabs
  module Types
    module ClientToolResultItemErrorType
      extend ::Elevenlabs::Internal::Types::Enum

      USER_REJECTED = :user_rejected
      EXTERNAL_SERVER = :external_server
      EXTERNAL_CLIENT = :external_client
      CUSTOMER_AUTH = :customer_auth
      CLIENT_TIMEOUT = :client_timeout
      UNKNOWN = :unknown

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
