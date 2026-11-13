# frozen_string_literal: true

module Elevenlabs
  module Types
    class BatchCallingCampaignInformation < ::Elevenlabs::Internal::Types::Model
      field :campaign_id, -> { String }, optional: false, nullable: false
      field :campaign_lead_id, -> { String }, optional: false, nullable: false
      field :cold_attempt, -> { Integer }, optional: true, nullable: true
      field :conversation_type, -> { ::Elevenlabs::Types::CampaignConversationType }, optional: true, nullable: true

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
