# frozen_string_literal: true

module Elevenlabs
  module Types
    class AlertingIntegrationNotifierResponse < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::AlertingIntegrationNotifierResponseType }, optional: true, nullable: false
      field :integration_type, -> { ::Elevenlabs::Types::AlertingIntegrationNotifierResponseIntegrationType }, optional: true, nullable: false
      field :connection_id, -> { String }, optional: false, nullable: false
      field :channel_id, -> { String }, optional: true, nullable: false

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
