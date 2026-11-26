# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Receptionists
      module Rules
        module Types
          class ReceptionUpdateAgentRuleRequest < ::Elevenlabs::Internal::Types::Model
            field :agent_id, -> { String }, optional: false, nullable: false
            field :rule_id, -> { String }, optional: false, nullable: false
            field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
            field :title, -> { String }, optional: false, nullable: false
            field :description, -> { String }, optional: false, nullable: false
            field :priority, -> { ::Elevenlabs::Types::RulePriority }, optional: true, nullable: false

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
end
