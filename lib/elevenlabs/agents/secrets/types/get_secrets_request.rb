# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Secrets
      module Types
        class GetSecretsRequest < ::Elevenlabs::Internal::Types::Model
          field :secret_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
