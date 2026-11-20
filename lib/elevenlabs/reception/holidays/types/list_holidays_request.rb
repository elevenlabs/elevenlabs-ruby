# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Holidays
      module Types
        class ListHolidaysRequest < ::Elevenlabs::Internal::Types::Model
          field :start_unix, -> { Integer }, optional: true, nullable: true

          field :end_unix, -> { Integer }, optional: true, nullable: true

          field :time_off_type, -> { ::Elevenlabs::Types::TimeOffType }, optional: true, nullable: true

          field :resource_id, -> { String }, optional: true, nullable: true

          field :location_id, -> { String }, optional: true, nullable: true

          field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
        end
      end
    end
  end
end
