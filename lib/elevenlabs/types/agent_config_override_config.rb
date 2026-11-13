# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentConfigOverrideConfig < ::Elevenlabs::Internal::Types::Model
      field :first_message, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :language, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :max_conversation_duration_message, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :prompt, -> { ::Elevenlabs::Types::PromptAgentAPIModelOverrideConfig }, optional: true, nullable: false

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
