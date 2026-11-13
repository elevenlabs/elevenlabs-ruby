# frozen_string_literal: true

module Elevenlabs
  module Agents
    module OutboundCampaigns
      module Leads
        module Types
          class GetLeadsRequest < ::Elevenlabs::Internal::Types::Model
            field :campaign_id, -> { String }, optional: false, nullable: false

            field :lead_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
