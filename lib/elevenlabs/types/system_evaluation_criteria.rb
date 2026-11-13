# frozen_string_literal: true

module Elevenlabs
  module Types
    class SystemEvaluationCriteria < ::Elevenlabs::Internal::Types::Model
      field :user_sentiment_score, -> { Float }, optional: false, nullable: false
      field :user_frustration_score, -> { Float }, optional: false, nullable: false

      def validate!
        Validator.validate_number!(user_sentiment_score, 'user_sentiment_score', min: -1, max: 1)
        Validator.validate_number!(user_frustration_score, 'user_frustration_score', min: 0, max: 1)
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
