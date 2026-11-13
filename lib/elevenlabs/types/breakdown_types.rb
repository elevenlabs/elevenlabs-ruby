# frozen_string_literal: true

module Elevenlabs
  module Types
    module BreakdownTypes
      extend ::Elevenlabs::Internal::Types::Enum

      NONE = :none
      VOICE = :voice
      VOICE_MULTIPLIER = :voice_multiplier
      USER = :user
      GROUPS = :groups
      API_KEYS = :api_keys
      ALL_API_KEYS = :all_api_keys
      PRODUCT_TYPE = :product_type
      MODEL = :model
      RESOURCE = :resource
      REQUEST_QUEUE = :request_queue
      REGION = :region
      SUBRESOURCE_ID = :subresource_id
      REPORTING_WORKSPACE_ID = :reporting_workspace_id
      HAS_API_KEY = :has_api_key
      REQUEST_SOURCE = :request_source

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
