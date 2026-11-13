# frozen_string_literal: true

module Elevenlabs
  module Types
    class CampaignSummaryCounts < ::Elevenlabs::Internal::Types::Model
      field :leads, -> { Integer }, optional: false, nullable: false
      field :terminal_leads, -> { Integer }, optional: false, nullable: false
      field :open_attention, -> { Integer }, optional: false, nullable: false
      field :delivery, -> { ::Elevenlabs::Types::RecipientDeliveryCounts }, optional: true, nullable: true

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
