# frozen_string_literal: true

module Elevenlabs
  module Types
    class APIIntegrationWebhookOverrides < ::Elevenlabs::Internal::Types::Model
      field :schema_overrides, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::Types::APIIntegrationWebhookOverridesSchemaOverridesValue] }, optional: true, nullable: true
      field :response_filter_mode, -> { ::Elevenlabs::Types::ResponseFilterMode }, optional: true, nullable: false
      field :response_filters, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :request_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::Types::APIIntegrationWebhookOverridesRequestHeadersValue] }, optional: true, nullable: true

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
