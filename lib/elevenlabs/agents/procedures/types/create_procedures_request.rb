# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Procedures
      module Types
        class CreateProceduresRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false

          field :branch_id, -> { String }, optional: false, nullable: false

          field :body, -> { ::Elevenlabs::Types::CreateProcedureRequestModel }, optional: true, nullable: false
        end
      end
    end
  end
end
