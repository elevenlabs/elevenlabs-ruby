# frozen_string_literal: true

module Elevenlabs
  module Types
    class FeaturesUsageCommonModel < ::Elevenlabs::Internal::Types::Model
      field :language_detection, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :transfer_to_agent, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :transfer_to_number, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :multivoice, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :dtmf_tones, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :external_mcp_servers, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :pii_zrm_workspace, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :pii_zrm_agent, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :tool_dynamic_variable_updates, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :is_livekit, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :voicemail_detection, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :dtmf_input, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :workflow, -> { ::Elevenlabs::Types::WorkflowFeaturesUsageCommonModel }, optional: true, nullable: false
      field :agent_testing, -> { ::Elevenlabs::Types::TestsFeatureUsageCommonModel }, optional: true, nullable: false
      field :versioning, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :file_input, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :freeform_procedure, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :structured_procedure, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false

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
