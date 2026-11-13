# frozen_string_literal: true

module Elevenlabs
  module Agents
    module OutboundCampaigns
      module Calls
        module Types
          class ListCallsRequest < ::Elevenlabs::Internal::Types::Model
            field :campaign_id, -> { String }, optional: false, nullable: false

            field :page_size, -> { Integer }, optional: true, nullable: true

            field :lead_id, -> { String }, optional: true, nullable: true

            field :status, -> { ::Elevenlabs::Types::CallStatus }, optional: true, nullable: true

            field :call_result, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::CallResult] }, optional: true, nullable: true

            field :stage, -> { ::Elevenlabs::Agents::OutboundCampaigns::Calls::Types::ListCallsRequestStage }, optional: true, nullable: true

            field :cursor, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
