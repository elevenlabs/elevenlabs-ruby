# frozen_string_literal: true

module Elevenlabs
  module Types
    class WebhookHmacSettings < ::Elevenlabs::Internal::Types::Model
      field :auth_type, -> { ::Elevenlabs::Types::WebhookHmacSettingsAuthType }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :webhook_url, -> { String }, optional: false, nullable: false
      field :request_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: true

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
