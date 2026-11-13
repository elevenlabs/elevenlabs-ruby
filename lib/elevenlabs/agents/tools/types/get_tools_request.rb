# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tools
      module Types
        class GetToolsRequest < ::Elevenlabs::Internal::Types::Model
          field :tool_id, -> { String }, optional: false, nullable: false

          field :environment, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
