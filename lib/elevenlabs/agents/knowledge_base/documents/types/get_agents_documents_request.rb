# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Documents
        module Types
          class GetAgentsDocumentsRequest < ::Elevenlabs::Internal::Types::Model
            field :documentation_id, -> { String }, optional: false, nullable: false

            field :dependent_type, -> { ::Elevenlabs::Types::KnowledgeBaseDependentType }, optional: true, nullable: true

            field :page_size, -> { Integer }, optional: true, nullable: true

            field :cursor, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
