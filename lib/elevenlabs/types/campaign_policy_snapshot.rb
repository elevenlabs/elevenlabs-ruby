# frozen_string_literal: true

module Elevenlabs
  module Types
    class CampaignPolicySnapshot < ::Elevenlabs::Internal::Types::Model
      field :timezone, -> { String }, optional: false, nullable: false
      field :retry_, -> { ::Elevenlabs::Types::RetryPolicy }, optional: false, nullable: false, api_name: 'retry'
      field :calling_periods, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::CallingPeriodPolicy] }, optional: false, nullable: false
      field :data_collection, -> { ::Elevenlabs::Types::DataCollectionPolicy }, optional: false, nullable: false
      field :followup_context, -> { ::Elevenlabs::Types::FollowupContextPolicy }, optional: false, nullable: false

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
