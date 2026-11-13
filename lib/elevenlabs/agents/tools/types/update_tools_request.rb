# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tools
      module Types
        class UpdateToolsRequest < ::Elevenlabs::Internal::Types::Model
          field :tool_id, -> { String }, optional: false, nullable: false

          field :body, -> { ::Elevenlabs::Types::ToolRequestModel }, optional: false, nullable: false
        end
      end
    end
  end
end
