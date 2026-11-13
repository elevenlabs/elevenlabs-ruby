# frozen_string_literal: true

module Elevenlabs
  module Agents
    module OutboundCampaigns
      module Types
        class StopOutboundCampaignsRequest < ::Elevenlabs::Internal::Types::Model
          field :campaign_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
