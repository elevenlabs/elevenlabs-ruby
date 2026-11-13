# frozen_string_literal: true

module Elevenlabs
  module Types
    module UpdateOAuth2ClientCredsRequestAuthType
      extend ::Elevenlabs::Internal::Types::Enum

      OAUTH2_CLIENT_CREDENTIALS = :oauth2_client_credentials

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
