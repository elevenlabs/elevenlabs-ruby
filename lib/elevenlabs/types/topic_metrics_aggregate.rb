# frozen_string_literal: true

module Elevenlabs
  module Types
    class TopicMetricsAggregate < ::Elevenlabs::Internal::Types::Model
      field :conversation_count, -> { Integer }, optional: true, nullable: false
      field :sentiment, -> { ::Elevenlabs::Types::TopicSentimentAggregate }, optional: true, nullable: true
      field :evaluation_criteria, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TopicEvaluationCriteriaAggregate] }, optional: true, nullable: false

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
