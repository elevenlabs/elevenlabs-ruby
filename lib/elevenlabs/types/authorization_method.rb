# frozen_string_literal: true

module Elevenlabs
  module Types
    module AuthorizationMethod
      extend ::Elevenlabs::Internal::Types::Enum

      INVALID = :invalid
      PUBLIC = :public
      AUTHORIZATION_HEADER = :authorization_header
      SIGNED_URL = :signed_url
      SHAREABLE_LINK = :shareable_link
      LIVEKIT_TOKEN = :livekit_token
      LIVEKIT_TOKEN_WEBSITE = :livekit_token_website
      GENESYS_API_KEY = :genesys_api_key
      AVAYA_API_KEY = :avaya_api_key
      AUDIOCODES_API_KEY = :audiocodes_api_key
      WHATSAPP = :whatsapp
      SMS = :sms

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
