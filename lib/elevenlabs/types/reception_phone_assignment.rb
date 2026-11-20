# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionPhoneAssignment < ::Elevenlabs::Internal::Types::Model
      field :phone_number, -> { String }, optional: true, nullable: true
      field :is_byo, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :provider, -> { ::Elevenlabs::Types::ReceptionPhoneProvider }, optional: true, nullable: false
      field :nanp_area_code, -> { Integer }, optional: true, nullable: false
      field :customer_facing_agent_id, -> { String }, optional: true, nullable: true
      field :deactivated_at_unix, -> { Integer }, optional: true, nullable: true
      field :deactivation_reason, -> { ::Elevenlabs::Types::ReceptionPhoneAssignmentDeactivationReason }, optional: true, nullable: true
      field :regulatory_status, -> { ::Elevenlabs::Types::ReceptionPhoneRegulatoryStatus }, optional: true, nullable: true
      field :regulatory_number_type, -> { ::Elevenlabs::Types::ApplicationNumberType }, optional: true, nullable: true
      field :regulatory_country, -> { String }, optional: true, nullable: true
      field :id, -> { String }, optional: false, nullable: false
      field :created_at_unix, -> { Integer }, optional: true, nullable: false
      field :updated_at_unix, -> { Integer }, optional: true, nullable: false
      field :is_active, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :accepts_public_calls, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
