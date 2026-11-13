# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Types
      class UpdateAgentRequest < ::Elevenlabs::Internal::Types::Model
        field :conversation_config, -> { ::Elevenlabs::Types::ConversationalConfig }, optional: true, nullable: false
        field :platform_settings, -> { ::Elevenlabs::Types::AgentPlatformSettingsRequestModel }, optional: true, nullable: false
        field :workflow, -> { ::Elevenlabs::Types::AgentWorkflowRequestModel }, optional: true, nullable: false
        field :name, -> { String }, optional: true, nullable: true
        field :tags, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
        field :version_description, -> { String }, optional: true, nullable: true
        field :procedures, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::ProcedureVersionRef] }, optional: true, nullable: true

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
