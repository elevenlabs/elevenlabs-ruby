# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Procedures
      module Drafts
        module Types
          class DeleteDraftsRequest < ::Elevenlabs::Internal::Types::Model
            field :agent_id, -> { String }, optional: false, nullable: false

            field :branch_id, -> { String }, optional: false, nullable: false

            field :procedure_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
