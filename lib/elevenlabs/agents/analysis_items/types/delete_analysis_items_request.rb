# frozen_string_literal: true

module Elevenlabs
  module Agents
    module AnalysisItems
      module Types
        class DeleteAnalysisItemsRequest < ::Elevenlabs::Internal::Types::Model
          field :analysis_item_id, -> { String }, optional: false, nullable: false

          field :force, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
        end
      end
    end
  end
end
