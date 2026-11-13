# frozen_string_literal: true

module Elevenlabs
  module Agents
    module WhatsappAccounts
      module Types
        class ListWhatsappAccountsRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
