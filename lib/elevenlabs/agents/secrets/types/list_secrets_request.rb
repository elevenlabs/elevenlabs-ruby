# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Secrets
      module Types
        class ListSecretsRequest < ::Elevenlabs::Internal::Types::Model
          field :page_size, -> { Integer }, optional: true, nullable: true

          field :dependency_limit, -> { Integer }, optional: true, nullable: true

          field :search, -> { String }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
