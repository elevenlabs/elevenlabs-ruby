# frozen_string_literal: true

module Elevenlabs
  module Types
    class SubmitCampaignResponse < ::Elevenlabs::Internal::Types::Model
      field :campaign, -> { ::Elevenlabs::Types::CampaignResponse }, optional: false, nullable: false
      field :created, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :within_calling_window, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
