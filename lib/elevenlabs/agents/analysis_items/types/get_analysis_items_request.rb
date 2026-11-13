# frozen_string_literal: true

module Elevenlabs
  module Agents
    module AnalysisItems
      module Types
        class GetAnalysisItemsRequest < ::Elevenlabs::Internal::Types::Model
          field :analysis_item_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
