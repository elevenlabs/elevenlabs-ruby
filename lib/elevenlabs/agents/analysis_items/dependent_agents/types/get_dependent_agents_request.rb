# frozen_string_literal: true

module Elevenlabs
  module Agents
    module AnalysisItems
      module DependentAgents
        module Types
          class GetDependentAgentsRequest < ::Elevenlabs::Internal::Types::Model
            field :analysis_item_id, -> { String }, optional: false, nullable: false

            field :page_size, -> { Integer }, optional: true, nullable: true

            field :cursor, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
