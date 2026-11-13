# frozen_string_literal: true

module Elevenlabs
  module Types
    class BehaviorOverride < ::Elevenlabs::Internal::Types::Model
      field :verbosity, -> { ::Elevenlabs::Types::Verbosity }, optional: true, nullable: true
      field :output_format, -> { ::Elevenlabs::Types::OutputFormat }, optional: true, nullable: true
      field :interaction_budget, -> { ::Elevenlabs::Types::InteractionBudget }, optional: true, nullable: true

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
