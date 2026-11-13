# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationConfigClientOverrideInput < ::Elevenlabs::Internal::Types::Model
      field :asr, -> { ::Elevenlabs::Types::AsrConversationalConfigOverride }, optional: true, nullable: true
      field :turn, -> { ::Elevenlabs::Types::TurnConfigOverride }, optional: true, nullable: true
      field :tts, -> { ::Elevenlabs::Types::TtsConversationalConfigOverride }, optional: true, nullable: true
      field :conversation, -> { ::Elevenlabs::Types::ConversationConfigOverride }, optional: true, nullable: true
      field :agent, -> { ::Elevenlabs::Types::AgentConfigOverrideInput }, optional: true, nullable: true

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
