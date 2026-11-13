# frozen_string_literal: true

module Elevenlabs
  module Types
    class WidgetTextContents < ::Elevenlabs::Internal::Types::Model
      field :main_label, -> { String }, optional: true, nullable: true
      field :start_call, -> { String }, optional: true, nullable: true
      field :start_chat, -> { String }, optional: true, nullable: true
      field :new_call, -> { String }, optional: true, nullable: true
      field :end_call, -> { String }, optional: true, nullable: true
      field :mute_microphone, -> { String }, optional: true, nullable: true
      field :change_language, -> { String }, optional: true, nullable: true
      field :collapse, -> { String }, optional: true, nullable: true
      field :expand, -> { String }, optional: true, nullable: true
      field :copied, -> { String }, optional: true, nullable: true
      field :accept_terms, -> { String }, optional: true, nullable: true
      field :dismiss_terms, -> { String }, optional: true, nullable: true
      field :listening_status, -> { String }, optional: true, nullable: true
      field :speaking_status, -> { String }, optional: true, nullable: true
      field :connecting_status, -> { String }, optional: true, nullable: true
      field :chatting_status, -> { String }, optional: true, nullable: true
      field :queue_waiting_status, -> { String }, optional: true, nullable: true
      field :queue_waiting_status_short, -> { String }, optional: true, nullable: true
      field :input_label, -> { String }, optional: true, nullable: true
      field :input_placeholder, -> { String }, optional: true, nullable: true
      field :input_placeholder_text_only, -> { String }, optional: true, nullable: true
      field :input_placeholder_new_conversation, -> { String }, optional: true, nullable: true
      field :user_ended_conversation, -> { String }, optional: true, nullable: true
      field :agent_ended_conversation, -> { String }, optional: true, nullable: true
      field :conversation_id, -> { String }, optional: true, nullable: true
      field :error_occurred, -> { String }, optional: true, nullable: true
      field :queue_timed_out, -> { String }, optional: true, nullable: true
      field :copy_id, -> { String }, optional: true, nullable: true
      field :initiate_feedback, -> { String }, optional: true, nullable: true
      field :request_follow_up_feedback, -> { String }, optional: true, nullable: true
      field :thanks_for_feedback, -> { String }, optional: true, nullable: true
      field :thanks_for_feedback_details, -> { String }, optional: true, nullable: true
      field :follow_up_feedback_placeholder, -> { String }, optional: true, nullable: true
      field :submit, -> { String }, optional: true, nullable: true
      field :go_back, -> { String }, optional: true, nullable: true
      field :send_message, -> { String }, optional: true, nullable: true
      field :text_mode, -> { String }, optional: true, nullable: true
      field :voice_mode, -> { String }, optional: true, nullable: true
      field :switched_to_text_mode, -> { String }, optional: true, nullable: true
      field :switched_to_voice_mode, -> { String }, optional: true, nullable: true
      field :copy, -> { String }, optional: true, nullable: true
      field :download, -> { String }, optional: true, nullable: true
      field :wrap, -> { String }, optional: true, nullable: true
      field :agent_working, -> { String }, optional: true, nullable: true
      field :agent_done, -> { String }, optional: true, nullable: true
      field :agent_error, -> { String }, optional: true, nullable: true
      field :attach_file, -> { String }, optional: true, nullable: true
      field :remove_file, -> { String }, optional: true, nullable: true
      field :file_upload_error, -> { String }, optional: true, nullable: true
      field :file_type_unsupported, -> { String }, optional: true, nullable: true
      field :file_too_large, -> { String }, optional: true, nullable: true
      field :file_limit_reached, -> { String }, optional: true, nullable: true
      field :typing_indicator, -> { String }, optional: true, nullable: true
      field :rich_content_unavailable, -> { String }, optional: true, nullable: true

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
