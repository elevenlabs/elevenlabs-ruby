# frozen_string_literal: true

module Elevenlabs
  module Agents
    module OutboundCampaigns
      module Attention
        module Types
          class ListAttentionRequest < ::Elevenlabs::Internal::Types::Model
            field :campaign_id, -> { String }, optional: true, nullable: true

            field :include_resolved, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

            field :page_size, -> { Integer }, optional: true, nullable: true

            field :cursor, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
