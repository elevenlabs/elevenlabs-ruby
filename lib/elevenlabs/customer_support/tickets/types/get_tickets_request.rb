# frozen_string_literal: true

module Elevenlabs
  module CustomerSupport
    module Tickets
      module Types
        class GetTicketsRequest < ::Elevenlabs::Internal::Types::Model
          field :ticket_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
