# frozen_string_literal: true

module Elevenlabs
  module Types
    class CreateMtlsAuthRequest < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :auth_type, -> { ::Elevenlabs::Types::CreateMtlsAuthRequestAuthType }, optional: true, nullable: false
      field :provider, -> { String }, optional: false, nullable: false
      field :client_certificate, -> { String }, optional: false, nullable: false
      field :client_key, -> { String }, optional: false, nullable: false
      field :ca_certificate, -> { String }, optional: true, nullable: true
      field :key_passphrase, -> { String }, optional: true, nullable: true

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
