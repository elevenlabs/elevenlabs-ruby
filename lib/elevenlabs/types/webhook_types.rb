# frozen_string_literal: true

module Elevenlabs
  module Types
    module WebhookTypes
      extend ::Elevenlabs::Internal::Types::Enum

      PROJECT_CONVERSION_STATUS = :project_conversion_status
      CHAPTER_CONVERSION_STATUS = :chapter_conversion_status
      POST_CALL_TRANSCRIPTION = :post_call_transcription
      POST_CALL_TRANSCRIPTION_OTEL = :post_call_transcription_otel
      POST_CALL_AUDIO = :post_call_audio
      POST_CALL_UNREDACTED_TRANSCRIPTION = :post_call_unredacted_transcription
      POST_CALL_UNREDACTED_TRANSCRIPTION_OTEL = :post_call_unredacted_transcription_otel
      POST_CALL_UNREDACTED_AUDIO = :post_call_unredacted_audio
      POST_CALL_ANALYSIS = :post_call_analysis
      CALL_INITIATION_FAILURE = :call_initiation_failure
      CONVERSATION_INITIATION_CLIENT_DATA = :conversation_initiation_client_data
      ANSWERING_MACHINE_DETECTION = :answering_machine_detection
      VOICE_REMOVAL_NOTICE = :voice_removal_notice
      VOICE_REMOVAL_NOTICE_WITHDRAWN = :voice_removal_notice_withdrawn
      VOICE_REMOVED = :voice_removed
      SPEECH_TO_TEXT_TRANSCRIPTION = :speech_to_text_transcription
      WEBHOOK_ERROR = :webhook_error
      SPEECH_TO_TEXT_BATCH = :speech_to_text_batch
      AGENT_QA_EVALUATION_COMPLETED = :agent_qa_evaluation_completed
      CONVAI_ALERTING_NOTIFICATION = :convai_alerting_notification
      FLOWS_GENERATION = :flows_generation
      FLOWS_TEMPLATE_RUN = :flows_template_run
      DUBBING_PROJECT_READY = :dubbing_project_ready
      DUBBING_PROJECT_FAILED = :dubbing_project_failed
      DUBBING_LANGUAGE_COMPLETED = :dubbing_language_completed
      DUBBING_LANGUAGE_FAILED = :dubbing_language_failed
      SUPPORT_TICKET_MESSAGE_ADDED = :support_ticket_message_added

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
