# frozen_string_literal: true

module Elevenlabs
  module Agents
    module PhoneNumbers
      module Types
        class ListV2PhoneNumbersRequest < ::Elevenlabs::Internal::Types::Model
          field :page_size, -> { Integer }, optional: true, nullable: true

          field :search, -> { String }, optional: true, nullable: true

          field :label, -> { String }, optional: true, nullable: true

          field :phone_number, -> { String }, optional: true, nullable: true

          field :provider, -> { ::Elevenlabs::Types::TelephonyProvider }, optional: true, nullable: true

          field :supports_outbound, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

          field :agent_id, -> { String }, optional: true, nullable: true

          field :branch_id, -> { String }, optional: true, nullable: true

          field :sort_by, -> { ::Elevenlabs::Types::PhoneNumberSortBy }, optional: true, nullable: true

          field :sort_direction, -> { ::Elevenlabs::Types::SortDirection }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
