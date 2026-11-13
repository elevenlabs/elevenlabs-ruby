# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentPlatformSettingsRequestModel < ::Elevenlabs::Internal::Types::Model
      field :evaluation, -> { ::Elevenlabs::Types::EvaluationSettingsInput }, optional: true, nullable: false
      field :widget, -> { ::Elevenlabs::Types::WidgetConfig }, optional: true, nullable: false
      field :data_collection, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::AnalysisProperty] }, optional: true, nullable: false
      field :data_collection_scopes, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::AnalysisScope] }, optional: true, nullable: false
      field :analysis_items, -> { ::Elevenlabs::Types::AgentAnalysisItemsInput }, optional: true, nullable: true
      field :overrides, -> { ::Elevenlabs::Types::ConversationInitiationClientDataConfigInput }, optional: true, nullable: false
      field :workspace_overrides, -> { ::Elevenlabs::Types::AgentWorkspaceOverridesInput }, optional: true, nullable: false
      field :testing, -> { ::Elevenlabs::Types::AgentTestingSettings }, optional: true, nullable: false
      field :archived, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :guardrails, -> { ::Elevenlabs::Types::GuardrailsV1Input }, optional: true, nullable: false
      field :summary_language, -> { String }, optional: true, nullable: true
      field :auto_translate_transcript_to_app_language, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :auth, -> { ::Elevenlabs::Types::AuthSettings }, optional: true, nullable: false
      field :call_limits, -> { ::Elevenlabs::Types::AgentCallLimits }, optional: true, nullable: false
      field :queueing_config, -> { ::Elevenlabs::Types::AgentQueueingConfig }, optional: true, nullable: false
      field :privacy, -> { ::Elevenlabs::Types::PrivacyConfigInput }, optional: true, nullable: false
      field :trust_context, -> { ::Elevenlabs::Types::AgentTrustContext }, optional: true, nullable: false
      field :analysis_llm, -> { ::Elevenlabs::Types::Llm }, optional: true, nullable: false
      field :topic_discovery, -> { Object }, optional: true, nullable: false
      field :sentiment_analysis, -> { Object }, optional: true, nullable: false
      field :alerting, -> { ::Elevenlabs::Types::AlertingSettings }, optional: true, nullable: true

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
