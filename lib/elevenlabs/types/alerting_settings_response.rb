# frozen_string_literal: true

module Elevenlabs
  module Types
    class AlertingSettingsResponse < ::Elevenlabs::Internal::Types::Model
      field :monitor_configs, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::AlertingMonitorConfig] }, optional: true, nullable: false
      field :auto_resolve_after_inactive_minutes, -> { Integer }, optional: true, nullable: true
      field :notifiers, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AlertingSettingsResponseNotifiersItem] }, optional: true, nullable: false

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
