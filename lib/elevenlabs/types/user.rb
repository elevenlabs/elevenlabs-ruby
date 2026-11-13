# frozen_string_literal: true

module Elevenlabs
  module Types
    class User < ::Elevenlabs::Internal::Types::Model
      field :user_id, -> { String }, optional: false, nullable: false
      field :workspace_id, -> { String }, optional: false, nullable: false
      field :subscription, -> { ::Elevenlabs::Types::SubscriptionResponse }, optional: false, nullable: false
      field :is_new_user, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :can_use_delayed_payment_methods, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :is_onboarding_completed, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :is_onboarding_checklist_completed, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :show_compliance_terms, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :first_name, -> { String }, optional: true, nullable: true
      field :is_api_key_hashed, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :xi_api_key_preview, -> { String }, optional: true, nullable: true
      field :referral_link_code, -> { String }, optional: true, nullable: true
      field :partnerstack_partner_default_link, -> { String }, optional: true, nullable: true
      field :created_at, -> { Integer }, optional: false, nullable: false
      field :seat_type, -> { ::Elevenlabs::Types::SeatType }, optional: false, nullable: false

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
