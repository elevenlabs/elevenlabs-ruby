# frozen_string_literal: true

module Elevenlabs
  module Types
    module OAuth2JwtResponseTokenResponseField
      extend ::Elevenlabs::Internal::Types::Enum

      ACCESS_TOKEN = :access_token
      ID_TOKEN = :id_token

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
