# frozen_string_literal: true

module Elevenlabs
  module Agents
    module BatchCalls
      module Types
        class ListBatchCallsRequest < ::Elevenlabs::Internal::Types::Model
          field :limit, -> { Integer }, optional: true, nullable: true

          field :last_doc, -> { String }, optional: true, nullable: true

          field :agent_id, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
