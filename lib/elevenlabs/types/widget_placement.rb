# frozen_string_literal: true

module Elevenlabs
  module Types
    module WidgetPlacement
      extend ::Elevenlabs::Internal::Types::Enum

      TOP_LEFT = :'top-left'
      TOP = :top
      TOP_RIGHT = :'top-right'
      BOTTOM_LEFT = :'bottom-left'
      BOTTOM = :bottom
      BOTTOM_RIGHT = :'bottom-right'

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
