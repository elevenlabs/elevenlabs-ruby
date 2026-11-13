# frozen_string_literal: true

module Elevenlabs
  module Agents
    module PhoneNumbers
      module Types
        class ListPhoneNumbersRequest < ::Elevenlabs::Internal::Types::Model
          field :provider, -> { ::Elevenlabs::Types::TelephonyProvider }, optional: true, nullable: true

          field :agent_id, -> { String }, optional: true, nullable: true

          field :branch_id, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
