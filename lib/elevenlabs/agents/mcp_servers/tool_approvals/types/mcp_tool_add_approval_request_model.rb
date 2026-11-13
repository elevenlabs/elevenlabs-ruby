# frozen_string_literal: true

module Elevenlabs
  module Agents
    module McpServers
      module ToolApprovals
        module Types
          class McpToolAddApprovalRequestModel < ::Elevenlabs::Internal::Types::Model
            field :tool_name, -> { String }, optional: false, nullable: false
            field :tool_description, -> { String }, optional: false, nullable: false
            field :input_schema, -> { Object }, optional: true, nullable: false
            field :approval_policy, -> { ::Elevenlabs::Types::McpToolApprovalPolicy }, optional: true, nullable: false

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
