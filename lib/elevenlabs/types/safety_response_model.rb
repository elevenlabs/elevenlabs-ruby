# frozen_string_literal: true

module Elevenlabs
  module Types
    class SafetyResponseModel < ::Elevenlabs::Internal::Types::Model
      field :is_blocked_ivc, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :is_blocked_non_ivc, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :ignore_safety_evaluation, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
