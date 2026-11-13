# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Messages
        module Types
          class TextSearchMessagesRequest < ::Elevenlabs::Internal::Types::Model
            field :text_query, -> { String }, optional: false, nullable: false

            field :agent_id, -> { String }, optional: true, nullable: true

            field :visited_agent_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :visited_agent_branch_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :triggered_procedure_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :call_successful, -> { ::Elevenlabs::Types::EvaluationResultFilter }, optional: true, nullable: true

            field :call_start_before_unix, -> { Integer }, optional: true, nullable: true

            field :call_start_after_unix, -> { Integer }, optional: true, nullable: true

            field :call_duration_min_secs, -> { Integer }, optional: true, nullable: true

            field :call_duration_max_secs, -> { Integer }, optional: true, nullable: true

            field :rating_max, -> { Integer }, optional: true, nullable: true

            field :rating_min, -> { Integer }, optional: true, nullable: true

            field :has_feedback_comment, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

            field :user_id, -> { String }, optional: true, nullable: true

            field :evaluation_params, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :data_collection_params, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :dynamic_variable_params, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :tool_names, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :tool_names_successful, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :tool_names_errored, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :tool_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :tool_ids_successful, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :tool_ids_errored, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :include_invalid_tool_calls, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

            field :main_languages, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :phone_number_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :whatsapp_phone_number_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :exclude_statuses, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Agents::Conversations::Messages::Types::TextSearchMessagesRequestExcludeStatusesItem] }, optional: true, nullable: true

            field :termination_reasons, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :page_size, -> { Integer }, optional: true, nullable: true

            field :summary_mode, -> { ::Elevenlabs::Agents::Conversations::Messages::Types::TextSearchMessagesRequestSummaryMode }, optional: true, nullable: true

            field :conversation_initiation_source, -> { ::Elevenlabs::Types::ConversationInitiationSource }, optional: true, nullable: true

            field :text_only, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

            field :conversation_product_type, -> { ::Elevenlabs::Types::ConversationProduct }, optional: true, nullable: true

            field :branch_id, -> { String }, optional: true, nullable: true

            field :version_id, -> { String }, optional: true, nullable: true

            field :topic_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :sort_by, -> { ::Elevenlabs::Types::MessageSearchSortBy }, optional: true, nullable: true

            field :cursor, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
