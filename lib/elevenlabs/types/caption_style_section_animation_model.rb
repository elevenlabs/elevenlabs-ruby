# frozen_string_literal: true

module Elevenlabs
  module Types
    class CaptionStyleSectionAnimationModel < ::Elevenlabs::Internal::Types::Model
      field :enter_type, -> { ::Elevenlabs::Types::CaptionStyleSectionAnimationModelEnterType }, optional: false, nullable: false
      field :exit_type, -> { ::Elevenlabs::Types::CaptionStyleSectionAnimationModelExitType }, optional: false, nullable: false

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
