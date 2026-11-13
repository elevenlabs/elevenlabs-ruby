# frozen_string_literal: true

module Elevenlabs
  module Types
    class UpdateOAuth2ClientCredsRequest < ::Elevenlabs::Internal::Types::Model
      field :auth_type, -> { ::Elevenlabs::Types::UpdateOAuth2ClientCredsRequestAuthType }, optional: true, nullable: false
      field :provider, -> { String }, optional: true, nullable: true
      field :client_id, -> { String }, optional: true, nullable: true
      field :scopes, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :extra_params, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: true
      field :basic_auth_in_header, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :client_secret, -> { String }, optional: true, nullable: true
      field :custom_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: true

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
