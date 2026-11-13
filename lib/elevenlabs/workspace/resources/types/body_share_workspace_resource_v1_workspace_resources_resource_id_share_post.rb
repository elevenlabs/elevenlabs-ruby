# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module Resources
      module Types
        class BodyShareWorkspaceResourceV1WorkspaceResourcesResourceIDSharePost < ::Elevenlabs::Internal::Types::Model
          field :role, -> { ::Elevenlabs::Workspace::Resources::Types::BodyShareWorkspaceResourceV1WorkspaceResourcesResourceIDSharePostRole }, optional: false, nullable: false
          field :resource_type, -> { ::Elevenlabs::Types::WorkspaceResourceType }, optional: false, nullable: false
          field :user_email, -> { String }, optional: true, nullable: true
          field :group_id, -> { String }, optional: true, nullable: true
          field :workspace_api_key_id, -> { String }, optional: true, nullable: true

          def self.load(str)
            coerce(::JSON.parse(str, symbolize_names: true))
          end

          def self.dump(value)
            coerced = coerce(value)
            ::JSON.generate(coerced.nil? || !coerced.respond_to?(:to_h) ? coerced : coerced.to_h)
          end
        end
      end
    end
  end
end
