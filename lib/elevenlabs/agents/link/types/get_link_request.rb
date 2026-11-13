# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Link
      module Types
        class GetLinkRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
