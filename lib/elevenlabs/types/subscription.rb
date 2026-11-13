# frozen_string_literal: true

module Elevenlabs
  module Types
    class Subscription < ::Elevenlabs::Internal::Types::Model
      field :tier, -> { String }, optional: false, nullable: false
      field :character_count, -> { Integer }, optional: false, nullable: false
      field :character_limit, -> { Integer }, optional: false, nullable: false
      field :max_character_limit_extension, -> { Integer }, optional: false, nullable: true
      field :max_credit_limit_extension, -> { ::Elevenlabs::Types::SubscriptionMaxCreditLimitExtension }, optional: false, nullable: false
      field :can_extend_character_limit, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :allowed_to_extend_character_limit, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :next_character_count_reset_unix, -> { Integer }, optional: true, nullable: true
      field :voice_slots_used, -> { Integer }, optional: false, nullable: false
      field :professional_voice_slots_used, -> { Integer }, optional: false, nullable: false
      field :professional_voice_slots_used_in_workspace, -> { Integer }, optional: false, nullable: false
      field :voice_limit, -> { Integer }, optional: false, nullable: false
      field :max_voice_add_edits, -> { Integer }, optional: true, nullable: true
      field :voice_add_edit_counter, -> { Integer }, optional: false, nullable: false
      field :professional_voice_limit, -> { Integer }, optional: false, nullable: false
      field :can_extend_voice_limit, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :can_use_instant_voice_cloning, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :can_use_professional_voice_cloning, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :currency, -> { ::Elevenlabs::Types::Currency }, optional: true, nullable: false
      field :current_overage, -> { ::Elevenlabs::Types::Price }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::SubscriptionStatusType }, optional: false, nullable: false
      field :billing_period, -> { ::Elevenlabs::Types::BillingPeriod }, optional: true, nullable: false
      field :character_refresh_period, -> { ::Elevenlabs::Types::CharacterRefreshPeriod }, optional: true, nullable: false
      field :next_invoice, -> { ::Elevenlabs::Types::InvoiceResponse }, optional: true, nullable: true
      field :open_invoices, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::InvoiceResponse] }, optional: false, nullable: false
      field :has_open_invoices, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :cancels_immediately, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :pending_change, -> { ::Elevenlabs::Types::SubscriptionPendingChange }, optional: true, nullable: true
      field :has_used_starter_coupon_on_account, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :has_used_creator_coupon_on_account, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :is_eligible_for_starter_promo, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
