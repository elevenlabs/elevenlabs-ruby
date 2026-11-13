# frozen_string_literal: true

module Elevenlabs
  module Types
    class PrivacyConfigOutput < ::Elevenlabs::Internal::Types::Model
      field :record_voice, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :retention_days, -> { Integer }, optional: true, nullable: false
      field :delete_transcript_and_pii, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :delete_audio, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :apply_to_existing_conversations, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :zero_retention_mode, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :conversation_history_redaction, -> { ::Elevenlabs::Types::ConversationHistoryRedactionConfig }, optional: true, nullable: false

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
