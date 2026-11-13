# frozen_string_literal: true

module Elevenlabs
  module ServiceAccounts
    module APIKeys
      module Types
        class DisableAPIKeysRequest < ::Elevenlabs::Internal::Types::Model
          field :service_account_user_id, -> { String }, optional: false, nullable: false

          field :api_key_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
