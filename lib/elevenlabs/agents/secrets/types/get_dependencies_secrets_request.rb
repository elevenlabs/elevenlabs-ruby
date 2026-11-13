# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Secrets
      module Types
        class GetDependenciesSecretsRequest < ::Elevenlabs::Internal::Types::Model
          field :secret_id, -> { String }, optional: false, nullable: false

          field :resource_type, -> { ::Elevenlabs::Types::SecretDependencyResourceType }, optional: false, nullable: false

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
