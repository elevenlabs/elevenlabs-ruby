# frozen_string_literal: true

module Elevenlabs
  module Types
    class CustomLlm < ::Elevenlabs::Internal::Types::Model
      field :url, -> { String }, optional: false, nullable: false
      field :model_id, -> { String }, optional: true, nullable: true
      field :api_key, -> { ::Elevenlabs::Types::CustomLlmAPIKey }, optional: true, nullable: true
      field :auth_connection, -> { ::Elevenlabs::Types::CustomLlmAuthConnection }, optional: true, nullable: true
      field :request_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::Types::CustomLlmRequestHeadersValue] }, optional: true, nullable: false
      field :api_version, -> { String }, optional: true, nullable: true
      field :api_type, -> { ::Elevenlabs::Types::CustomLlmapiType }, optional: true, nullable: false

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
