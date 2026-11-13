# frozen_string_literal: true

module Elevenlabs
  module Agents
    module McpServers
      module ToolApprovals
        module Types
          class DeleteToolApprovalsRequest < ::Elevenlabs::Internal::Types::Model
            field :mcp_server_id, -> { String }, optional: false, nullable: false

            field :tool_name, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
