# frozen_string_literal: true

module Elevenlabs
  module Types
    class AdhocAgentConfigOverrideForTestRequestModel < ::Elevenlabs::Internal::Types::Model
      field :conversation_config, -> { ::Elevenlabs::Types::ConversationalConfig }, optional: false, nullable: false
      field :platform_settings, -> { ::Elevenlabs::Types::AgentPlatformSettingsRequestModel }, optional: false, nullable: false
      field :workflow, -> { ::Elevenlabs::Types::AgentWorkflowRequestModel }, optional: true, nullable: false

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
