# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module Usage
      module Types
        module BodyGetWorkspaceUsageV1WorkspaceAnalyticsQueryUsageByProductOverTimePostGroupByItem
          extend ::Elevenlabs::Internal::Types::Enum

          PRODUCT_TYPE = :product_type
          MODEL = :model
          VOICE_ID = :voice_id
          USER_ID = :user_id
          FIAT_CURRENCY = :fiat_currency
          FIAT_CHARGE_TYPE = :fiat_charge_type
          REGION = :region
          REPORTING_WORKSPACE_ID = :reporting_workspace_id
          REQUEST_SOURCE = :request_source
          RESOURCE_ID = :resource_id
          SUBRESOURCE_ID = :subresource_id
          REQUEST_QUEUE_TYPE = :request_queue_type
          VOICE_MULTIPLIER = :voice_multiplier
          HASHED_XI_API_KEY = :hashed_xi_api_key
          BILLING_GROUP_ID = :billing_group_id
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
  end
end
