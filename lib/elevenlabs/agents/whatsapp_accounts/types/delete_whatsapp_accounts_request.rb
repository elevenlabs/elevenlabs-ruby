# frozen_string_literal: true

module Elevenlabs
  module Agents
    module WhatsappAccounts
      module Types
        class DeleteWhatsappAccountsRequest < ::Elevenlabs::Internal::Types::Model
          field :phone_number_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
