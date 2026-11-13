# frozen_string_literal: true

module Elevenlabs
  module Types
    module AlertingSettingsResponseNotifiersItem
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::AlertingWebhookNotifierResponse }, key: 'webhook'
      member -> { ::Elevenlabs::Types::AlertingIntegrationNotifierResponse }, key: 'integration'

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
