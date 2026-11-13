# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentConfig < ::Elevenlabs::Internal::Types::Model
      field :first_message, -> { String }, optional: true, nullable: false
      field :language, -> { String }, optional: true, nullable: false
      field :hinglish_mode, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :dynamic_variables, -> { Object }, optional: true, nullable: false
      field :disable_first_message_interruptions, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :max_conversation_duration_message, -> { String }, optional: true, nullable: false
      field :text_behavior_overrides, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::BehaviorOverride] }, optional: true, nullable: true
      field :prompt, -> { ::Elevenlabs::Types::PromptAgentAPIModelInput }, optional: true, nullable: false

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
