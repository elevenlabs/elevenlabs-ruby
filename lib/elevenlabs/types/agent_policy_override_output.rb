# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentPolicyOverrideOutput < ::Elevenlabs::Internal::Types::Model
      field :timezone, -> { String }, optional: true, nullable: true
      field :retry_, -> { ::Elevenlabs::Types::RetryPolicy }, optional: true, nullable: false, api_name: 'retry'
      field :calling_periods, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::CallingPeriod] }, optional: true, nullable: true
      field :data_collection, -> { ::Elevenlabs::Types::DataCollectionConfig }, optional: true, nullable: false
      field :followup_context, -> { ::Elevenlabs::Types::FollowupContextPolicy }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(calling_periods, 'calling_periods', min_items: 1)
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
