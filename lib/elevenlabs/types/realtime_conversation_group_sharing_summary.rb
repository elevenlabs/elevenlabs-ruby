# frozen_string_literal: true

module Elevenlabs
  module Types
    class RealtimeConversationGroupSharingSummary < ::Elevenlabs::Internal::Types::Model
      field :people_count, -> { Integer }, optional: false, nullable: false
      field :shared_with_everyone, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :everyone_role, -> { ::Elevenlabs::Types::RealtimeConversationGroupSharingSummaryEveryoneRole }, optional: true, nullable: true

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
