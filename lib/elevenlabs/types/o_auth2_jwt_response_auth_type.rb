# frozen_string_literal: true

module Elevenlabs
  module Types
    module OAuth2JwtResponseAuthType
      extend ::Elevenlabs::Internal::Types::Enum

      OAUTH2_JWT = :oauth2_jwt

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
