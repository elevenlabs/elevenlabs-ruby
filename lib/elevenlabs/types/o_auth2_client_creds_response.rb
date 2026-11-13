# frozen_string_literal: true

module Elevenlabs
  module Types
    class OAuth2ClientCredsResponse < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :auth_type, -> { ::Elevenlabs::Types::OAuth2ClientCredsResponseAuthType }, optional: true, nullable: false
      field :provider, -> { String }, optional: false, nullable: false
      field :client_id, -> { String }, optional: false, nullable: false
      field :token_url, -> { String }, optional: false, nullable: false
      field :scopes, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :extra_params, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :basic_auth_in_header, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :used_by, -> { ::Elevenlabs::Types::AuthConnectionDependencies }, optional: true, nullable: true
      field :status, -> { ::Elevenlabs::Types::AuthConnectionStatus }, optional: true, nullable: false
      field :status_detail, -> { String }, optional: true, nullable: true
      field :status_updated_at, -> { String }, optional: true, nullable: true
      field :custom_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false

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
