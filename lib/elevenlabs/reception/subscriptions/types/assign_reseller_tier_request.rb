# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Subscriptions
      module Types
        class AssignResellerTierRequest < ::Elevenlabs::Internal::Types::Model
          field :workspace_id, -> { String }, optional: false, nullable: false
          field :tier_id, -> { String }, optional: false, nullable: false
          field :billing_period, -> { ::Elevenlabs::Reception::Subscriptions::Types::AssignResellerTierRequestBillingPeriod }, optional: true, nullable: false
          field :idempotency_key, -> { String }, optional: true, nullable: true

          def validate!
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
