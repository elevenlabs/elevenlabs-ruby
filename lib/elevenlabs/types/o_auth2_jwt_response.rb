# frozen_string_literal: true

module Elevenlabs
  module Types
    class OAuth2JwtResponse < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :auth_type, -> { ::Elevenlabs::Types::OAuth2JwtResponseAuthType }, optional: true, nullable: false
      field :provider, -> { String }, optional: false, nullable: false
      field :algorithm, -> { ::Elevenlabs::Types::OAuth2JwtResponseAlgorithm }, optional: true, nullable: false
      field :key_id, -> { String }, optional: true, nullable: true
      field :issuer, -> { String }, optional: false, nullable: false
      field :audience, -> { String }, optional: false, nullable: false
      field :subject, -> { String }, optional: false, nullable: false
      field :expiration_seconds, -> { Integer }, optional: true, nullable: false
      field :extra_params, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :extra_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :token_url, -> { String }, optional: false, nullable: false
      field :scopes, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :token_response_field, -> { ::Elevenlabs::Types::OAuth2JwtResponseTokenResponseField }, optional: true, nullable: false
      field :jwt_usage, -> { ::Elevenlabs::Types::OAuth2JwtResponseJwtUsage }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :used_by, -> { ::Elevenlabs::Types::AuthConnectionDependencies }, optional: true, nullable: false
      field :status, -> { ::Elevenlabs::Types::AuthConnectionStatus }, optional: true, nullable: false
      field :status_detail, -> { String }, optional: true, nullable: true
      field :status_updated_at, -> { String }, optional: true, nullable: true

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
