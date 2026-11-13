# frozen_string_literal: true

module Elevenlabs
  module Types
    class CampaignResponse < ::Elevenlabs::Internal::Types::Model
      field :campaign_id, -> { String }, optional: false, nullable: false
      field :call_name, -> { String }, optional: false, nullable: false
      field :agent_id, -> { String }, optional: false, nullable: false
      field :channel_config, -> { ::Elevenlabs::Types::CampaignResponseChannelConfig }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::CampaignStatus }, optional: false, nullable: false
      field :policy, -> { ::Elevenlabs::Types::CampaignPolicySnapshot }, optional: false, nullable: false
      field :variant, -> { ::Elevenlabs::Types::CampaignVariant }, optional: false, nullable: false
      field :source, -> { ::Elevenlabs::Types::CampaignSource }, optional: false, nullable: true
      field :created_at_unix, -> { Integer }, optional: false, nullable: false
      field :scheduled_time_unix, -> { Integer }, optional: false, nullable: true
      field :updated_at_unix, -> { Integer }, optional: false, nullable: false
      field :branch_id, -> { String }, optional: false, nullable: true
      field :environment, -> { String }, optional: false, nullable: true
      field :target_concurrency_limit, -> { Integer }, optional: false, nullable: true
      field :channel, -> { ::Elevenlabs::Types::OutboundChannel }, optional: false, nullable: false
      field :mode, -> { ::Elevenlabs::Types::OutboundMode }, optional: false, nullable: false
      field :counts, -> { ::Elevenlabs::Types::CampaignSummaryCounts }, optional: false, nullable: false
      field :agent_name, -> { String }, optional: false, nullable: false

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
