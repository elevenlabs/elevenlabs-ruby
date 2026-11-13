# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationSentimentAnalysis < ::Elevenlabs::Internal::Types::Model
      field :overall_label, -> { ::Elevenlabs::Types::ConversationSentimentAnalysisOverallLabel }, optional: false, nullable: false
      field :overall_sentiment_score, -> { Float }, optional: false, nullable: false
      field :overall_frustration_score, -> { Float }, optional: false, nullable: false
      field :min_user_sentiment_score, -> { Float }, optional: false, nullable: false
      field :max_user_frustration_score, -> { Float }, optional: false, nullable: false
      field :num_scored_user_turns, -> { Integer }, optional: false, nullable: false

      def validate!
        Validator.validate_number!(overall_sentiment_score, 'overall_sentiment_score', min: -1, max: 1)
        Validator.validate_number!(overall_frustration_score, 'overall_frustration_score', min: 0, max: 1)
        Validator.validate_number!(min_user_sentiment_score, 'min_user_sentiment_score', min: -1, max: 1)
        Validator.validate_number!(max_user_frustration_score, 'max_user_frustration_score', min: 0, max: 1)
        ::Elevenlabs::Validator.validate_integer!(num_scored_user_turns, 'num_scored_user_turns', min: 0)
      end

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
