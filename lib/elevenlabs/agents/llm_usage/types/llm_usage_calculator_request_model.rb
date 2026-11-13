# frozen_string_literal: true

module Elevenlabs
  module Agents
    module LlmUsage
      module Types
        class LlmUsageCalculatorRequestModel < ::Elevenlabs::Internal::Types::Model
          field :prompt_length, -> { Integer }, optional: true, nullable: true
          field :number_of_pages, -> { Integer }, optional: true, nullable: true
          field :rag_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
          field :service_tier, -> { ::Elevenlabs::Types::LlmServiceTier }, optional: true, nullable: false

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
  end
end
