# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tools
      module Types
        class DeleteToolsRequest < ::Elevenlabs::Internal::Types::Model
          field :tool_id, -> { String }, optional: false, nullable: false

          field :force, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
        end
      end
    end
  end
end
