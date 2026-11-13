# frozen_string_literal: true

module Elevenlabs
  module Types
    class CompactionSettingsWorkflowOverride < ::Elevenlabs::Internal::Types::Model
      field :enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :soft_trigger_fraction, -> { Float }, optional: true, nullable: true
      field :tail_size, -> { Integer }, optional: true, nullable: true
      field :min_reclaimable_tokens, -> { Integer }, optional: true, nullable: true

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
