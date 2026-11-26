# frozen_string_literal: true

module Elevenlabs
  module Types
    class Feedback < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::FeedbackType }, optional: true, nullable: false
      field :event_id, -> { Integer }, optional: false, nullable: false
      field :score, -> { ::Elevenlabs::Types::FeedbackScore }, optional: true, nullable: false

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
