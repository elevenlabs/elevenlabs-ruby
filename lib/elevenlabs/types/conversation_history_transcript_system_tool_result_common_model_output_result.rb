# frozen_string_literal: true

module Elevenlabs
  module Types
    module ConversationHistoryTranscriptSystemToolResultCommonModelOutputResult
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :result_type
      member -> { ::Elevenlabs::Types::DummyToolResultModel }, key: 'dummy'
      member -> { ::Elevenlabs::Types::EndCallToolResultModel }, key: 'end_call_success'
      member -> { ::Elevenlabs::Types::EndProcedureToolResultErrorModel }, key: 'end_procedure_error'
      member -> { ::Elevenlabs::Types::EndProcedureToolResultSuccessModel }, key: 'end_procedure_success'
      member -> { ::Elevenlabs::Types::KnowledgeBaseRagToolResultModel }, key: 'knowledge_base_rag_success'
      member -> { ::Elevenlabs::Types::KnowledgeBaseToolResultModel }, key: 'knowledge_base_success'
      member -> { ::Elevenlabs::Types::LanguageDetectionToolResultModel }, key: 'language_detection_success'
      member -> { ::Elevenlabs::Types::PlayDtmfResultErrorModel }, key: 'play_dtmf_error'
      member -> { ::Elevenlabs::Types::PlayDtmfResultSuccessModel }, key: 'play_dtmf_success'
      member -> { ::Elevenlabs::Types::SkipTurnToolResponseModel }, key: 'skip_turn_success'
      member -> { ::Elevenlabs::Types::StartProcedureToolResultErrorModel }, key: 'start_procedure_error'
      member -> { ::Elevenlabs::Types::StartProcedureToolResultSuccessModel }, key: 'start_procedure_success'
      member -> { ::Elevenlabs::Types::TestToolResultModel }, key: 'testing_tool_result'
      member -> { ::Elevenlabs::Types::TransferToAgentToolResultErrorModel }, key: 'transfer_to_agent_error'
      member -> { ::Elevenlabs::Types::TransferToAgentToolResultSuccessModelOutput }, key: 'transfer_to_agent_success'
      member -> { ::Elevenlabs::Types::TransferToNumberResultAmazonConnectSuccessModel }, key: 'transfer_to_number_amazon_connect_success'
      member -> { ::Elevenlabs::Types::TransferToNumberResultErrorModel }, key: 'transfer_to_number_error'
      member -> { ::Elevenlabs::Types::TransferToNumberResultExotelSuccessModel }, key: 'transfer_to_number_exotel_success'
      member -> { ::Elevenlabs::Types::TransferToNumberResultSipSuccessModel }, key: 'transfer_to_number_sip_success'
      member -> { ::Elevenlabs::Types::TransferToNumberResultTwilioSuccessModel }, key: 'transfer_to_number_twilio_success'
      member -> { ::Elevenlabs::Types::VoiceMailDetectionResultSuccessModel }, key: 'voicemail_detection_success'

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
