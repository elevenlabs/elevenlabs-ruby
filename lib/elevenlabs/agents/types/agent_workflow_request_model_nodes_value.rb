# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Types
      module AgentWorkflowRequestModelNodesValue
        extend ::Elevenlabs::Internal::Types::Union

        discriminant :type
        member -> { ::Elevenlabs::Types::WorkflowEndNodeModelInput }, key: 'end'
        member -> { ::Elevenlabs::Types::WorkflowOverrideAgentNodeModelInput }, key: 'override_agent'
        member -> { ::Elevenlabs::Types::WorkflowPhoneNumberNodeModelInput }, key: 'phone_number'
        member -> { ::Elevenlabs::Types::WorkflowStandaloneAgentNodeModelInput }, key: 'standalone_agent'
        member -> { ::Elevenlabs::Types::WorkflowStartNodeModelInput }, key: 'start'
        member -> { ::Elevenlabs::Types::WorkflowToolNodeModelInput }, key: 'tool'
        member -> { ::Elevenlabs::Types::WorkflowSayNodeModelInput }, key: 'say'
        member -> { ::Elevenlabs::Types::WorkflowUpdateStateNodeModelInput }, key: 'update_state'

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
