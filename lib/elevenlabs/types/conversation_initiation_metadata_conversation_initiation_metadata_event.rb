# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationInitiationMetadataConversationInitiationMetadataEvent < ::Elevenlabs::Internal::Types::Model
      field :conversation_id, -> { String }, optional: false, nullable: false
      field :agent_output_audio_format, -> { ::Elevenlabs::Types::ConversationInitiationMetadataConversationInitiationMetadataEventAgentOutputAudioFormat }, optional: false, nullable: false
      field :user_input_audio_format, -> { ::Elevenlabs::Types::ConversationInitiationMetadataConversationInitiationMetadataEventUserInputAudioFormat }, optional: false, nullable: false

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
