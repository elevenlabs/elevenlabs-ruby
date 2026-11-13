# frozen_string_literal: true

module Elevenlabs
  module Types
    class OutboundSipTrunkConfigRequestModel < ::Elevenlabs::Internal::Types::Model
      field :address, -> { String }, optional: false, nullable: false
      field :transport, -> { ::Elevenlabs::Types::SipTrunkTransportEnum }, optional: true, nullable: false
      field :media_encryption, -> { ::Elevenlabs::Types::SipMediaEncryptionEnum }, optional: true, nullable: false
      field :headers, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :attributes_to_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :credentials, -> { ::Elevenlabs::Types::SipTrunkCredentialsRequestModel }, optional: true, nullable: false
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
