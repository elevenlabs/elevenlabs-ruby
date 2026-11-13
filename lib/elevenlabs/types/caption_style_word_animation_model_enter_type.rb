# frozen_string_literal: true

module Elevenlabs
  module Types
    module CaptionStyleWordAnimationModelEnterType
      extend ::Elevenlabs::Internal::Types::Enum

      NONE = :none
      FADE = :fade
      SCALE = :scale
      POP = :pop
      SLIDE_UP = :slide_up
      SLIDE_DOWN = :slide_down
      SLAM = :slam
      SCALE_DOWN = :scale_down
      SLIDE_IN = :slide_in

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
