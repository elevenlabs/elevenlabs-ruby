# frozen_string_literal: true

module Elevenlabs
  module Agents
    module PhoneNumbers
      module Types
        class GetSipMessagesPhoneNumbersRequest < ::Elevenlabs::Internal::Types::Model
          field :phone_number_id, -> { String }, optional: false, nullable: false

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
