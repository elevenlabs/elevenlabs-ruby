# frozen_string_literal: true

module Elevenlabs
  module Agents
    module OutboundCampaigns
      module Leads
        module Types
          class ListLeadsRequest < ::Elevenlabs::Internal::Types::Model
            field :campaign_id, -> { String }, optional: false, nullable: false

            field :page_size, -> { Integer }, optional: true, nullable: true

            field :search, -> { String }, optional: true, nullable: true

            field :status, -> { ::Elevenlabs::Agents::OutboundCampaigns::Leads::Types::ListLeadsRequestStatus }, optional: true, nullable: true

            field :disposition, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TerminalDisposition] }, optional: true, nullable: true

            field :cursor, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
