# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Types
      module AgentWorkflowResponseModelNodesValue
        extend ::Elevenlabs::Internal::Types::Union

        discriminant :type
        member -> { ::Elevenlabs::Types::WorkflowEndNodeModelOutput }, key: 'end'
        member -> { ::Elevenlabs::Types::WorkflowOverrideAgentNodeModelOutput }, key: 'override_agent'
        member -> { ::Elevenlabs::Types::WorkflowPhoneNumberNodeModelOutput }, key: 'phone_number'
        member -> { ::Elevenlabs::Types::WorkflowStandaloneAgentNodeModelOutput }, key: 'standalone_agent'
        member -> { ::Elevenlabs::Types::WorkflowStartNodeModelOutput }, key: 'start'
        member -> { ::Elevenlabs::Types::WorkflowToolNodeModelOutput }, key: 'tool'
        member -> { ::Elevenlabs::Types::WorkflowSayNodeModelOutput }, key: 'say'
        member -> { ::Elevenlabs::Types::WorkflowUpdateStateNodeModelOutput }, key: 'update_state'

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
