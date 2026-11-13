# frozen_string_literal: true

module Elevenlabs
  module Agents
    module OutboundCampaigns
      module Types
        class ListOutboundCampaignsRequest < ::Elevenlabs::Internal::Types::Model
          field :page_size, -> { Integer }, optional: true, nullable: true

          field :status, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::CampaignStatus] }, optional: true, nullable: true

          field :agent_id, -> { String }, optional: true, nullable: true

          field :channel, -> { ::Elevenlabs::Types::OutboundChannel }, optional: true, nullable: true

          field :mode, -> { ::Elevenlabs::Agents::OutboundCampaigns::Types::ListOutboundCampaignsRequestMode }, optional: true, nullable: true

          field :search, -> { String }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
