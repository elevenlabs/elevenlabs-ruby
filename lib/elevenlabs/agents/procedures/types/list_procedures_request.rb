# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Procedures
      module Types
        class ListProceduresRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false

          field :branch_id, -> { String }, optional: false, nullable: false

          field :agent_version_id, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
