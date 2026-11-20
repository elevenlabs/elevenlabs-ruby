# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Holidays
      module Types
        class ReceptionUpdateHolidayRequestPatch < ::Elevenlabs::Internal::Types::Model
          field :name, -> { String }, optional: true, nullable: false
          field :start_date, -> { ::Elevenlabs::Types::DateModel }, optional: true, nullable: false
          field :end_date, -> { ::Elevenlabs::Types::DateModel }, optional: true, nullable: false
          field :holiday_type, -> { ::Elevenlabs::Types::HolidayType }, optional: true, nullable: false
          field :override_hours, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TimeRangeModel] }, optional: true, nullable: true
          field :time_off_type, -> { ::Elevenlabs::Types::TimeOffType }, optional: true, nullable: false
          field :resource_id, -> { String }, optional: true, nullable: true
          field :location_id, -> { String }, optional: true, nullable: true
          field :reason, -> { String }, optional: true, nullable: true

          def self.load(str)
            coerce(::JSON.parse(str, symbolize_names: true))
          end

          def self.dump(value)
            coerced = coerce(value)
            ::JSON.generate(coerced.nil? || !coerced.respond_to?(:to_h) ? coerced : coerced.to_h)
          end
        end
      end
    end
  end
end
