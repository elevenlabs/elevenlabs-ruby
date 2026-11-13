# frozen_string_literal: true

module Elevenlabs
  module Agents
    module PhoneNumbers
      module Types
        class DeletePhoneNumbersRequest < ::Elevenlabs::Internal::Types::Model
          field :phone_number_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
