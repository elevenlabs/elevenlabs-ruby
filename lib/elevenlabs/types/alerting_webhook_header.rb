# frozen_string_literal: true

module Elevenlabs
  module Types
    class AlertingWebhookHeader < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :is_secret, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :value, -> { String }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_string!(name, 'name', max_length: 256)
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
