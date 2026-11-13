# frozen_string_literal: true

module Elevenlabs
  module Types
    class SentimentAggregate < ::Elevenlabs::Internal::Types::Model
      field :scored_conversation_count, -> { Integer }, optional: false, nullable: false
      field :positive_count, -> { Integer }, optional: false, nullable: false
      field :neutral_count, -> { Integer }, optional: false, nullable: false
      field :negative_count, -> { Integer }, optional: false, nullable: false
      field :average_sentiment_score, -> { Float }, optional: false, nullable: true
      field :average_frustration_score, -> { Float }, optional: false, nullable: true
      field :recent_scored_conversation_count, -> { Integer }, optional: false, nullable: false
      field :recent_positive_count, -> { Integer }, optional: false, nullable: false
      field :recent_neutral_count, -> { Integer }, optional: false, nullable: false
      field :recent_negative_count, -> { Integer }, optional: false, nullable: false
      field :recent_average_sentiment_score, -> { Float }, optional: false, nullable: true
      field :recent_average_frustration_score, -> { Float }, optional: false, nullable: true

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
