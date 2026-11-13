# frozen_string_literal: true

module Elevenlabs
  module Types
    module ClipAnimationEnterEffect
      extend ::Elevenlabs::Internal::Types::Enum

      NONE = :none
      FADE = :fade
      FLOAT = :float
      GENTLE_FLOAT = :gentle_float
      ZOOM_IN = :zoom_in
      DROP = :drop
      SLIDE_LEFT = :slide_left
      SLIDE_RIGHT = :slide_right
      SLIDE_UP = :slide_up
      SLIDE_DOWN = :slide_down
      POP = :pop
      BOUNCE = :bounce
      SPIN = :spin
      SLIDE_BOUNCE = :slide_bounce

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
