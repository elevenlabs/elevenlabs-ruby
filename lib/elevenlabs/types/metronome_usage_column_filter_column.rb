# frozen_string_literal: true

module Elevenlabs
  module Types
    module MetronomeUsageColumnFilterColumn
      extend ::Elevenlabs::Internal::Types::Enum

      MODEL = :model
      REQUEST_SOURCE = :request_source
      FIAT_CHARGE_TYPE = :fiat_charge_type
      FIAT_CURRENCY = :fiat_currency
      USER_ID = :user_id
      HASHED_XI_API_KEY = :hashed_xi_api_key
      REGION = :region
      REPORTING_WORKSPACE_ID = :reporting_workspace_id
      BILLING_GROUP_ID = :billing_group_id
      PRODUCT_TYPE = :product_type
      SURFACE = :surface
      ACTOR = :actor

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
