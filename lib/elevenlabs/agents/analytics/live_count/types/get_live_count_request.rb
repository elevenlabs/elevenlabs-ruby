# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Analytics
      module LiveCount
        module Types
          class GetLiveCountRequest < ::Elevenlabs::Internal::Types::Model
            field :agent_id, -> { String }, optional: true, nullable: true

            field :agent_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
