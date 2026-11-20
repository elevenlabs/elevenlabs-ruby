# frozen_string_literal: true

module Elevenlabs
  module Reception
    module KnowledgeSources
      module Types
        class ListKnowledgeSourcesRequest < ::Elevenlabs::Internal::Types::Model
          field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
        end
      end
    end
  end
end
