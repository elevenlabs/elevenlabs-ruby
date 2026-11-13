# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Procedures
      module Types
        class GetProceduresRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false

          field :branch_id, -> { String }, optional: false, nullable: false

          field :procedure_id, -> { String }, optional: false, nullable: false

          field :version_id, -> { String }, optional: true, nullable: true

          field :agent_version_id, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
