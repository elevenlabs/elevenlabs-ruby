# frozen_string_literal: true

module Elevenlabs
  module AgentWorkflows
    module NodeTypes
      module_function

      # Whether this SDK version's generated request model has a member for a node type. Read from the
      # generated union's discriminant keys rather than a hand-maintained list, so a regeneration that
      # adds a node type is picked up without a change to the builder. Requires the SDK to be loaded
      # (require 'elevenlabs').
      def known
        @known ||= ::Elevenlabs::Types::AgentWorkflowRequestModelNodesValue
                   .members.map { |key, _type| key.to_s }
      end

      def model_knows_node_type?(node_type)
        known.include?(node_type)
      end
    end
  end
end
