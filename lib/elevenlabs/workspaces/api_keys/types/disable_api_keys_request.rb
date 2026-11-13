# frozen_string_literal: true

module Elevenlabs
  module Workspaces
    module APIKeys
      module Types
        class DisableAPIKeysRequest < ::Elevenlabs::Internal::Types::Model
          field :api_key_name, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
