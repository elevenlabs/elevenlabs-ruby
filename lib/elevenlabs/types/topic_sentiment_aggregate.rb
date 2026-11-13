# frozen_string_literal: true

module Elevenlabs
  module Types
    class TopicSentimentAggregate < ::Elevenlabs::Internal::Types::Model
      field :sentiment, -> { ::Elevenlabs::Types::NumericDistributionAggregate }, optional: true, nullable: false
      field :frustration, -> { ::Elevenlabs::Types::NumericDistributionAggregate }, optional: true, nullable: false
      field :positive_count, -> { Integer }, optional: true, nullable: false
      field :neutral_count, -> { Integer }, optional: true, nullable: false
      field :negative_count, -> { Integer }, optional: true, nullable: false

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
