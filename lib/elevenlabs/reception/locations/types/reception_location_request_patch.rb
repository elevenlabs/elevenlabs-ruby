# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Locations
      module Types
        class ReceptionLocationRequestPatch < ::Elevenlabs::Internal::Types::Model
          field :location_id, -> { String }, optional: false, nullable: false
          field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
          field :name, -> { String }, optional: true, nullable: false
          field :address, -> { String }, optional: true, nullable: false
          field :notes, -> { String }, optional: true, nullable: false
          field :operating_hours, -> { ::Elevenlabs::Types::WorkingHours }, optional: true, nullable: false
          field :customer_facing_name, -> { String }, optional: true, nullable: false
          field :max_concurrent_appointments, -> { Integer }, optional: true, nullable: false
          field :is_active, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
