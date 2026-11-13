# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Types
      class DeleteAgentsRequest < ::Elevenlabs::Internal::Types::Model
        field :agent_id, -> { String }, optional: false, nullable: false

        field :force, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      end
    end
  end
end
