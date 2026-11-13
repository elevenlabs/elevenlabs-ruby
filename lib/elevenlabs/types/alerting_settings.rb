# frozen_string_literal: true

module Elevenlabs
  module Types
    class AlertingSettings < ::Elevenlabs::Internal::Types::Model
      field :monitor_configs, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::AlertingMonitorConfig] }, optional: true, nullable: false
      field :auto_resolve_after_inactive_minutes, -> { Integer }, optional: true, nullable: true
      field :notifiers, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AlertingSettingsNotifiersItem] }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(auto_resolve_after_inactive_minutes, 'auto_resolve_after_inactive_minutes', min: 1)
        ::Elevenlabs::Validator.validate_array!(notifiers, 'notifiers', max_items: 10)
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
