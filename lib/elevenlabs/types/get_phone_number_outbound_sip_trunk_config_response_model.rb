# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetPhoneNumberOutboundSipTrunkConfigResponseModel < ::Elevenlabs::Internal::Types::Model
      field :address, -> { String }, optional: false, nullable: false
      field :transport, -> { ::Elevenlabs::Types::SipTrunkTransportEnum }, optional: false, nullable: false
      field :media_encryption, -> { ::Elevenlabs::Types::SipMediaEncryptionEnum }, optional: false, nullable: false
      field :headers, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :attributes_to_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :has_auth_credentials, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :username, -> { String }, optional: true, nullable: true
      field :has_outbound_trunk, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :enabled_codecs, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::MediaCodec] }, optional: true, nullable: false

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
