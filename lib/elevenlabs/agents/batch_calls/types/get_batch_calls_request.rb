# frozen_string_literal: true

module Elevenlabs
  module Agents
    module BatchCalls
      module Types
        class GetBatchCallsRequest < ::Elevenlabs::Internal::Types::Model
          field :batch_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
