# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationalConfigAPIModelWorkflowOverrideInput < ::Elevenlabs::Internal::Types::Model
      field :asr, -> { ::Elevenlabs::Types::AsrConversationalConfigWorkflowOverride }, optional: true, nullable: true
      field :turn, -> { ::Elevenlabs::Types::TurnConfigWorkflowOverride }, optional: true, nullable: true
      field :tts, -> { ::Elevenlabs::Types::TtsConversationalConfigWorkflowOverrideInput }, optional: true, nullable: true
      field :conversation, -> { ::Elevenlabs::Types::ConversationConfigWorkflowOverrideInput }, optional: true, nullable: true
      field :language_presets, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::LanguagePresetInput] }, optional: true, nullable: true
      field :vad, -> { ::Elevenlabs::Types::VadConfigWorkflowOverride }, optional: true, nullable: true
      field :agent, -> { ::Elevenlabs::Types::AgentConfigAPIModelWorkflowOverrideInput }, optional: true, nullable: true

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
