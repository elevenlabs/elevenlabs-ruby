# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Versions
      module Types
        class GetVersionsRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false

          field :version_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
