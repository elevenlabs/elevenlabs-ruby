# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Types
      class BodyCreateAgentV1ConvaiAgentsCreatePost < ::Elevenlabs::Internal::Types::Model
        field :conversation_config, -> { ::Elevenlabs::Types::ConversationalConfig }, optional: false, nullable: false
        field :platform_settings, -> { ::Elevenlabs::Types::AgentPlatformSettingsRequestModel }, optional: true, nullable: true
        field :workflow, -> { ::Elevenlabs::Types::AgentWorkflowRequestModel }, optional: true, nullable: false
        field :name, -> { String }, optional: true, nullable: true
        field :tags, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

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
end
