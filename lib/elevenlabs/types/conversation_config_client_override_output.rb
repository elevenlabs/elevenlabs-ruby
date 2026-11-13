# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationConfigClientOverrideOutput < ::Elevenlabs::Internal::Types::Model
      field :asr, -> { ::Elevenlabs::Types::AsrConversationalConfigOverride }, optional: true, nullable: false
      field :turn, -> { ::Elevenlabs::Types::TurnConfigOverride }, optional: true, nullable: false
      field :tts, -> { ::Elevenlabs::Types::TtsConversationalConfigOverride }, optional: true, nullable: false
      field :conversation, -> { ::Elevenlabs::Types::ConversationConfigOverride }, optional: true, nullable: false
      field :agent, -> { ::Elevenlabs::Types::AgentConfigOverrideOutput }, optional: true, nullable: true

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
