# frozen_string_literal: true

module Elevenlabs
  module Agents
    module BatchCalls
      module Types
        class ExportBatchCallsRequest < ::Elevenlabs::Internal::Types::Model
          field :batch_id, -> { String }, optional: false, nullable: false

          field :limit, -> { Integer }, optional: true, nullable: true
        end
      end
    end
  end
end
