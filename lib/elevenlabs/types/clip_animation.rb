# frozen_string_literal: true

module Elevenlabs
  module Types
    class ClipAnimation < ::Elevenlabs::Internal::Types::Model
      field :enter_effect, -> { ::Elevenlabs::Types::ClipAnimationEnterEffect }, optional: true, nullable: false
      field :enter_duration_ms, -> { Integer }, optional: true, nullable: false
      field :exit_effect, -> { ::Elevenlabs::Types::ClipAnimationExitEffect }, optional: true, nullable: false
      field :exit_duration_ms, -> { Integer }, optional: true, nullable: false

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
