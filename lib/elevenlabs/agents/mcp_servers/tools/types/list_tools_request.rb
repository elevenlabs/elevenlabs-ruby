# frozen_string_literal: true

module Elevenlabs
  module Agents
    module McpServers
      module Tools
        module Types
          class ListToolsRequest < ::Elevenlabs::Internal::Types::Model
            field :mcp_server_id, -> { String }, optional: false, nullable: false

            field :environment, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
