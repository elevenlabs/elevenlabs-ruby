# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentWorkflowRequestModel < ::Elevenlabs::Internal::Types::Model
      field :edges, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::WorkflowEdgeModelInput] }, optional: true, nullable: false
      field :nodes, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::Types::AgentWorkflowRequestModelNodesValue] }, optional: true, nullable: false
      field :prevent_subagent_loops, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
