# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tools
      module Types
        class GetDependentAgentsToolsRequest < ::Elevenlabs::Internal::Types::Model
          field :tool_id, -> { String }, optional: false, nullable: false

          field :cursor, -> { String }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true
        end
      end
    end
  end
end
