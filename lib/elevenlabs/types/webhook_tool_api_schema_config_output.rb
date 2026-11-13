# frozen_string_literal: true

module Elevenlabs
  module Types
    class WebhookToolAPISchemaConfigOutput < ::Elevenlabs::Internal::Types::Model
      field :request_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::Types::WebhookToolAPISchemaConfigOutputRequestHeadersValue] }, optional: true, nullable: false
      field :url, -> { String }, optional: false, nullable: false
      field :method_, -> { ::Elevenlabs::Types::WebhookToolAPISchemaConfigOutputMethod }, optional: true, nullable: false, api_name: 'method'
      field :path_params_schema, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::LiteralJSONSchemaProperty] }, optional: true, nullable: false
      field :query_params_schema, -> { ::Elevenlabs::Types::QueryParamsJSONSchemaOutput }, optional: true, nullable: true
      field :request_body_schema, -> { ::Elevenlabs::Types::ObjectJSONSchemaPropertyOutput }, optional: true, nullable: true
      field :response_body_schema, -> { ::Elevenlabs::Types::ObjectJSONSchemaPropertyOutput }, optional: true, nullable: false
      field :response_filter, -> { ::Elevenlabs::Types::ResponseFilter }, optional: true, nullable: false
      field :content_type, -> { ::Elevenlabs::Types::WebhookToolAPISchemaConfigOutputContentType }, optional: true, nullable: false
      field :auth_resolved_params, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :auth_connection, -> { ::Elevenlabs::Types::WebhookToolAPISchemaConfigOutputAuthConnection }, optional: true, nullable: true

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
