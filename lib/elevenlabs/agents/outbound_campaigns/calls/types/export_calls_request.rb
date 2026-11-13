# frozen_string_literal: true

module Elevenlabs
  module Agents
    module OutboundCampaigns
      module Calls
        module Types
          class ExportCallsRequest < ::Elevenlabs::Internal::Types::Model
            field :campaign_id, -> { String }, optional: false, nullable: false

            field :limit, -> { Integer }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
