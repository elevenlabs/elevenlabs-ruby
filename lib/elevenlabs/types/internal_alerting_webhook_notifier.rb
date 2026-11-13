# frozen_string_literal: true

module Elevenlabs
  module Types
    class InternalAlertingWebhookNotifier < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::InternalAlertingWebhookNotifierType }, optional: true, nullable: false
      field :url, -> { String }, optional: false, nullable: false
      field :method_, -> { ::Elevenlabs::Types::AlertingWebhookMethod }, optional: true, nullable: false, api_name: 'method'
      field :headers, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AlertingWebhookHeader] }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(url, 'url', max_length: 2048)
        ::Elevenlabs::Validator.validate_array!(headers, 'headers', max_items: 25)
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
