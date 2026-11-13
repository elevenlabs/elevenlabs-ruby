# frozen_string_literal: true

module Elevenlabs
  module Types
    class WebhookToolAPISchemaConfigInput < ::Elevenlabs::Internal::Types::Model
      field :request_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::Types::WebhookToolAPISchemaConfigInputRequestHeadersValue] }, optional: true, nullable: false
      field :url, -> { String }, optional: false, nullable: false
      field :method_, -> { ::Elevenlabs::Types::WebhookToolAPISchemaConfigInputMethod }, optional: true, nullable: false, api_name: 'method'
      field :path_params_schema, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::LiteralJSONSchemaProperty] }, optional: true, nullable: false
      field :query_params_schema, -> { ::Elevenlabs::Types::QueryParamsJSONSchemaInput }, optional: true, nullable: true
      field :request_body_schema, -> { ::Elevenlabs::Types::ObjectJSONSchemaPropertyInput }, optional: true, nullable: true
      field :response_body_schema, -> { ::Elevenlabs::Types::ObjectJSONSchemaPropertyInput }, optional: true, nullable: false
      field :response_filter, -> { ::Elevenlabs::Types::ResponseFilter }, optional: true, nullable: true
      field :content_type, -> { ::Elevenlabs::Types::WebhookToolAPISchemaConfigInputContentType }, optional: true, nullable: false
      field :auth_resolved_params, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :auth_connection, -> { ::Elevenlabs::Types::WebhookToolAPISchemaConfigInputAuthConnection }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_array!(auth_resolved_params, 'auth_resolved_params', unique_items: true)
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
