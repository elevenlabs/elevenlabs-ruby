# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Staff
      module Types
        class ReceptionUpdateStaffRequestPatch < ::Elevenlabs::Internal::Types::Model
          field :staff_id, -> { String }, optional: false, nullable: false
          field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
          field :groups, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReceptionGroupMembership] }, optional: true, nullable: false
          field :ungrouped_rank, -> { Integer }, optional: true, nullable: true
          field :name, -> { String }, optional: true, nullable: false
          field :description, -> { String }, optional: true, nullable: false
          field :is_active, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
          field :email, -> { String }, optional: true, nullable: false
          field :phone, -> { String }, optional: true, nullable: false
          field :sms_notifications_opted_in, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
          field :photo_url, -> { String }, optional: true, nullable: true
          field :location_id, -> { String }, optional: true, nullable: true
          field :working_hours, -> { ::Elevenlabs::Types::WorkingHours }, optional: true, nullable: false
          field :display_on_booking_page, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
          field :customer_facing_name, -> { String }, optional: true, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_string!(photo_url, 'photo_url', min_length: 1, max_length: 2083)
          end

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
