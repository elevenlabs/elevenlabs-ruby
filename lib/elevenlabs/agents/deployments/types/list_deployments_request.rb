# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Deployments
      module Types
        class ListDeploymentsRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false

          field :page, -> { Integer }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true
        end
      end
    end
  end
end
