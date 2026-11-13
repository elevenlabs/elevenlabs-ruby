# frozen_string_literal: true

module Elevenlabs
  module Types
    class UnitTestRunResponseModel < ::Elevenlabs::Internal::Types::Model
      field :test_run_id, -> { String }, optional: false, nullable: false
      field :test_info, -> { ::Elevenlabs::Types::UnitTestRunResponseModelTestInfo }, optional: true, nullable: true
      field :test_invocation_id, -> { String }, optional: false, nullable: false
      field :agent_id, -> { String }, optional: false, nullable: false
      field :branch_id, -> { String }, optional: true, nullable: true
      field :version_id, -> { String }, optional: true, nullable: true
      field :ran_against_draft, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :workflow_node_id, -> { String }, optional: true, nullable: true
      field :status, -> { ::Elevenlabs::Types::TestRunStatus }, optional: false, nullable: false
      field :agent_responses, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationHistoryTranscriptCommonModelOutput] }, optional: true, nullable: true
      field :triggered_guardrails, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TriggeredGuardrailCommonModel] }, optional: true, nullable: false
      field :test_id, -> { String }, optional: false, nullable: false
      field :test_name, -> { String }, optional: true, nullable: false
      field :condition_result, -> { ::Elevenlabs::Types::TestConditionResultCommonModel }, optional: true, nullable: true
      field :last_updated_at_unix, -> { Integer }, optional: true, nullable: false
      field :metadata, -> { ::Elevenlabs::Types::TestRunMetadata }, optional: true, nullable: true
      field :root_folder_id, -> { String }, optional: true, nullable: true
      field :root_folder_name, -> { String }, optional: true, nullable: true
      field :environment, -> { String }, optional: true, nullable: true
      field :credits_used, -> { Integer }, optional: true, nullable: true
      field :charging, -> { ::Elevenlabs::Types::ConversationChargingCommonModel }, optional: true, nullable: true

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
