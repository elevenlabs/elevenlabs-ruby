# frozen_string_literal: true

module Elevenlabs
  module Types
    class UpdateOAuth2JwtRequest < ::Elevenlabs::Internal::Types::Model
      field :auth_type, -> { ::Elevenlabs::Types::UpdateOAuth2JwtRequestAuthType }, optional: true, nullable: false
      field :provider, -> { String }, optional: true, nullable: true
      field :algorithm, -> { ::Elevenlabs::Types::UpdateOAuth2JwtRequestAlgorithm }, optional: true, nullable: true
      field :key_id, -> { String }, optional: true, nullable: true
      field :issuer, -> { String }, optional: true, nullable: true
      field :audience, -> { String }, optional: true, nullable: true
      field :subject, -> { String }, optional: true, nullable: true
      field :expiration_seconds, -> { Integer }, optional: true, nullable: true
      field :extra_params, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: true
      field :scopes, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :token_response_field, -> { ::Elevenlabs::Types::UpdateOAuth2JwtRequestTokenResponseField }, optional: true, nullable: true
      field :jwt_usage, -> { ::Elevenlabs::Types::UpdateOAuth2JwtRequestJwtUsage }, optional: true, nullable: true
      field :extra_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: true
      field :secret_key, -> { String }, optional: true, nullable: true

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
