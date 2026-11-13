# frozen_string_literal: true

module Elevenlabs
  module Types
    class InboundSipTrunkConfigRequestModel < ::Elevenlabs::Internal::Types::Model
      field :allowed_addresses, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :allowed_numbers, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :media_encryption, -> { ::Elevenlabs::Types::SipMediaEncryptionEnum }, optional: true, nullable: false
      field :credentials, -> { ::Elevenlabs::Types::SipTrunkCredentialsRequestModel }, optional: true, nullable: true
      field :remote_domains, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :attributes_to_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false

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
