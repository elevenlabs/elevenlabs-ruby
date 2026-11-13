# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationalConfigAPIModelWorkflowOverrideOutput < ::Elevenlabs::Internal::Types::Model
      field :asr, -> { ::Elevenlabs::Types::AsrConversationalConfigWorkflowOverride }, optional: true, nullable: false
      field :turn, -> { ::Elevenlabs::Types::TurnConfigWorkflowOverride }, optional: true, nullable: false
      field :tts, -> { ::Elevenlabs::Types::TtsConversationalConfigWorkflowOverrideOutput }, optional: true, nullable: true
      field :conversation, -> { ::Elevenlabs::Types::ConversationConfigWorkflowOverrideOutput }, optional: true, nullable: true
      field :language_presets, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::LanguagePresetOutput] }, optional: true, nullable: true
      field :vad, -> { ::Elevenlabs::Types::VadConfigWorkflowOverride }, optional: true, nullable: false
      field :agent, -> { ::Elevenlabs::Types::AgentConfigAPIModelWorkflowOverrideOutput }, optional: true, nullable: true

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
