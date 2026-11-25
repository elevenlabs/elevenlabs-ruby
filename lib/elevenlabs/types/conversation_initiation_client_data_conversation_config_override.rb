# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationInitiationClientDataConversationConfigOverride < ::Elevenlabs::Internal::Types::Model
      field :asr, -> { ::Elevenlabs::Types::ConversationInitiationClientDataConversationConfigOverrideAsr }, optional: true, nullable: false
      field :turn, -> { ::Elevenlabs::Types::ConversationInitiationClientDataConversationConfigOverrideTurn }, optional: true, nullable: false
      field :tts, -> { ::Elevenlabs::Types::ConversationInitiationClientDataConversationConfigOverrideTts }, optional: true, nullable: false
      field :conversation, -> { ::Elevenlabs::Types::ConversationInitiationClientDataConversationConfigOverrideConversation }, optional: true, nullable: false
      field :agent, -> { ::Elevenlabs::Types::ConversationInitiationClientDataConversationConfigOverrideAgent }, optional: true, nullable: false

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
