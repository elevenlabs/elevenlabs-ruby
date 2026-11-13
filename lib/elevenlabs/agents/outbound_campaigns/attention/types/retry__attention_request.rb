# frozen_string_literal: true

module Elevenlabs
  module Agents
    module OutboundCampaigns
      module Attention
        module Types
          class RetryAttentionRequest < ::Elevenlabs::Internal::Types::Model
            field :attention_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
