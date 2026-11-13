# frozen_string_literal: true

module Elevenlabs
  module Types
    class UserFeedback < ::Elevenlabs::Internal::Types::Model
      field :score, -> { ::Elevenlabs::Types::UserFeedbackScore }, optional: false, nullable: false
      field :time_in_call_secs, -> { Integer }, optional: false, nullable: false

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
