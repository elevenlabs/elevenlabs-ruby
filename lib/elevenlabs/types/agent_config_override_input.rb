# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentConfigOverrideInput < ::Elevenlabs::Internal::Types::Model
      field :first_message, -> { String }, optional: true, nullable: true
      field :language, -> { String }, optional: true, nullable: true
      field :max_conversation_duration_message, -> { String }, optional: true, nullable: true
      field :prompt, -> { ::Elevenlabs::Types::PromptAgentAPIModelOverrideInput }, optional: true, nullable: true

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
