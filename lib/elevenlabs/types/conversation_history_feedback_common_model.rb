# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationHistoryFeedbackCommonModel < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::ConversationFeedbackType }, optional: true, nullable: true
      field :overall_score, -> { ::Elevenlabs::Types::UserFeedbackScore }, optional: true, nullable: false
      field :likes, -> { Integer }, optional: true, nullable: false
      field :dislikes, -> { Integer }, optional: true, nullable: false
      field :rating, -> { Integer }, optional: true, nullable: true
      field :comment, -> { String }, optional: true, nullable: true

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
