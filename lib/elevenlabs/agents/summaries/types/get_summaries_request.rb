# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Summaries
      module Types
        class GetSummariesRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
        end
      end
    end
  end
end
