# frozen_string_literal: true

module Elevenlabs
  module Types
    class CreatePrivateKeyJwtRequest < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :auth_type, -> { ::Elevenlabs::Types::CreatePrivateKeyJwtRequestAuthType }, optional: true, nullable: false
      field :provider, -> { String }, optional: false, nullable: false
      field :algorithm, -> { ::Elevenlabs::Types::CreatePrivateKeyJwtRequestAlgorithm }, optional: true, nullable: false
      field :key_id, -> { String }, optional: true, nullable: true
      field :issuer, -> { String }, optional: false, nullable: false
      field :audience, -> { String }, optional: false, nullable: false
      field :subject, -> { String }, optional: false, nullable: false
      field :expiration_seconds, -> { Integer }, optional: true, nullable: false
      field :extra_params, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :extra_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :secret_key, -> { String }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(expiration_seconds, 'expiration_seconds', min: 60, max: 86_400)
      end

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
