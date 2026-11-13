# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationalConfig < ::Elevenlabs::Internal::Types::Model
      field :asr, -> { ::Elevenlabs::Types::AsrConversationalConfig }, optional: true, nullable: false
      field :turn, -> { ::Elevenlabs::Types::TurnConfig }, optional: true, nullable: false
      field :tts, -> { ::Elevenlabs::Types::TtsConversationalConfigInput }, optional: true, nullable: false
      field :conversation, -> { ::Elevenlabs::Types::ConversationConfigInput }, optional: true, nullable: false
      field :language_presets, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::LanguagePresetInput] }, optional: true, nullable: false
      field :vad, -> { ::Elevenlabs::Types::VadConfig }, optional: true, nullable: false
      field :agent, -> { ::Elevenlabs::Types::AgentConfig }, optional: true, nullable: false

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
