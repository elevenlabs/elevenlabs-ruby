# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Drafts
      module Types
        class BodyCreateAgentDraftV1ConvaiAgentsAgentIDDraftsPost < ::Elevenlabs::Internal::Types::Model
          field :conversation_config, -> { Object }, optional: false, nullable: false
          field :platform_settings, -> { Object }, optional: false, nullable: false
          field :workflow, -> { ::Elevenlabs::Types::AgentWorkflowRequestModel }, optional: false, nullable: false
          field :name, -> { String }, optional: false, nullable: false
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
end
