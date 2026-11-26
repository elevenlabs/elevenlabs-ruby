# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Workspaces
      module Types
        class ReceptionProvisionResellerWorkspaceRequest < ::Elevenlabs::Internal::Types::Model
          field :business_name, -> { String }, optional: false, nullable: false
          field :vertical, -> { ::Elevenlabs::Types::ReceptionVertical }, optional: true, nullable: true
          field :charge_customer, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
          field :subscription, -> { ::Elevenlabs::Types::ProvisionResellerWorkspaceSubscription }, optional: true, nullable: true
          field :phone_number, -> { String }, optional: true, nullable: true
          field :members, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TeamInviteRequest] }, optional: true, nullable: false
          field :complete_onboarding, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
          field :metadata, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
          field :idempotency_key, -> { String }, optional: true, nullable: true

          def validate!
            ::Elevenlabs::Validator.validate_string!(business_name, 'business_name', min_length: 1, max_length: 100)
            ::Elevenlabs::Validator.validate_array!(members, 'members', max_items: 100)
            ::Elevenlabs::Validator.validate_string!(idempotency_key, 'idempotency_key', max_length: 255)
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
