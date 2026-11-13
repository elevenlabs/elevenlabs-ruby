# frozen_string_literal: true

module Elevenlabs
  module Types
    module SystemToolConfigInputParams
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :system_tool_type
      member -> { ::Elevenlabs::Types::EndCallToolConfig }, key: 'end_call'
      member -> { ::Elevenlabs::Types::EndProcedureToolConfig }, key: 'end_procedure'
      member -> { ::Elevenlabs::Types::KnowledgeBaseToolConfig }, key: 'knowledge_base'
      member -> { ::Elevenlabs::Types::KnowledgeBaseRagToolConfig }, key: 'knowledge_base_rag'
      member -> { ::Elevenlabs::Types::LanguageDetectionToolConfig }, key: 'language_detection'
      member -> { ::Elevenlabs::Types::PlayDtmfToolConfig }, key: 'play_keypad_touch_tone'
      member -> { ::Elevenlabs::Types::SkipTurnToolConfig }, key: 'skip_turn'
      member -> { ::Elevenlabs::Types::StartProcedureToolConfig }, key: 'start_procedure'
      member -> { ::Elevenlabs::Types::TransferToAgentToolConfigInput }, key: 'transfer_to_agent'
      member -> { ::Elevenlabs::Types::TransferToNumberToolConfigInput }, key: 'transfer_to_number'
      member -> { ::Elevenlabs::Types::VoicemailDetectionToolConfig }, key: 'voicemail_detection'

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
