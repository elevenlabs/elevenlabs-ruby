# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Branches
      module Types
        class BodyCreateANewBranchV1ConvaiAgentsAgentIDBranchesPost < ::Elevenlabs::Internal::Types::Model
          field :parent_version_id, -> { String }, optional: false, nullable: false
          field :name, -> { String }, optional: false, nullable: false
          field :description, -> { String }, optional: false, nullable: false
          field :conversation_config, -> { Object }, optional: true, nullable: true
          field :platform_settings, -> { Object }, optional: true, nullable: true
          field :workflow, -> { ::Elevenlabs::Types::AgentWorkflowRequestModel }, optional: true, nullable: false
          field :include_draft, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_string!(name, 'name', max_length: 140)
            ::Elevenlabs::Validator.validate_string!(description, 'description', max_length: 4096)
          end

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
