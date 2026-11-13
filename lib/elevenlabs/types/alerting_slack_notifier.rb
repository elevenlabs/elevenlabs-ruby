# frozen_string_literal: true

module Elevenlabs
  module Types
    class AlertingSlackNotifier < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::AlertingSlackNotifierType }, optional: true, nullable: false
      field :integration_type, -> { ::Elevenlabs::Types::AlertingSlackNotifierIntegrationType }, optional: true, nullable: false
      field :connection_id, -> { String }, optional: false, nullable: false
      field :channel_id, -> { String }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(connection_id, 'connection_id', min_length: 1)
        ::Elevenlabs::Validator.validate_string!(channel_id, 'channel_id', min_length: 1, max_length: 64)
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
