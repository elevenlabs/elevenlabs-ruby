# frozen_string_literal: true

module Elevenlabs
  module Types
    class OpenAiTurnDetection < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::TurnDetectionType }, optional: true, nullable: false
      field :eagerness, -> { ::Elevenlabs::Types::Eagerness }, optional: true, nullable: false
      field :create_response, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :interrupt_response, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :threshold, -> { Float }, optional: true, nullable: true
      field :prefix_padding_ms, -> { Integer }, optional: true, nullable: true
      field :silence_duration_ms, -> { Integer }, optional: true, nullable: true
      field :turn_timeout, -> { Float }, optional: true, nullable: false

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
