# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionLocationResponse < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :address, -> { String }, optional: true, nullable: false
      field :notes, -> { String }, optional: true, nullable: false
      field :operating_hours, -> { ::Elevenlabs::Types::WorkingHours }, optional: true, nullable: false
      field :customer_facing_name, -> { String }, optional: true, nullable: false
      field :max_concurrent_appointments, -> { Integer }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :deactivated_at_unix, -> { Integer }, optional: true, nullable: true
      field :deactivation_reason, -> { ::Elevenlabs::Types::ReceptionLocationDeactivationReason }, optional: true, nullable: true
      field :is_active, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(max_concurrent_appointments, 'max_concurrent_appointments', min: 1, max: 999)
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
