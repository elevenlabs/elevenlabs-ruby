# frozen_string_literal: true

module Elevenlabs
  module Types
    module UsersSortBy
      extend ::Elevenlabs::Internal::Types::Enum

      LAST_CONTACT_UNIX_SECS = :last_contact_unix_secs
      CONVERSATION_COUNT = :conversation_count
      AVERAGE_SENTIMENT_SCORE = :average_sentiment_score

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
