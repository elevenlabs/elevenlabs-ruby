# frozen_string_literal: true

module Elevenlabs
  module Types
    class ProvisionResellerWorkspaceResponse < ::Elevenlabs::Internal::Types::Model
      field :workspace_id, -> { String }, optional: false, nullable: false
      field :business_name, -> { String }, optional: false, nullable: false
      field :billing_tier, -> { String }, optional: false, nullable: true
      field :receptionist_count, -> { Integer }, optional: false, nullable: false
      field :calls_last30days, -> { Integer }, optional: false, nullable: false, api_name: 'calls_last_30_days'
      field :created_at_unix, -> { Integer }, optional: false, nullable: false
      field :subscription, -> { ::Elevenlabs::Types::ResellerWorkspaceSubscription }, optional: true, nullable: false
      field :charge_customer, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :has_payment_issue, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :onboarding_completed_at_unix, -> { Integer }, optional: true, nullable: true
      field :member_results, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TeamInviteResult] }, optional: true, nullable: false

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
