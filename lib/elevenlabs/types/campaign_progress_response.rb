# frozen_string_literal: true

module Elevenlabs
  module Types
    class CampaignProgressResponse < ::Elevenlabs::Internal::Types::Model
      field :leads, -> { ::Elevenlabs::Types::LeadsProgress }, optional: false, nullable: false
      field :conversations, -> { ::Elevenlabs::Types::ConversationProgress }, optional: false, nullable: false
      field :next_call_time_unix, -> { Integer }, optional: false, nullable: true

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
