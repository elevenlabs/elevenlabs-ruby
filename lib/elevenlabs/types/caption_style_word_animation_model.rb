# frozen_string_literal: true

module Elevenlabs
  module Types
    class CaptionStyleWordAnimationModel < ::Elevenlabs::Internal::Types::Model
      field :enter_type, -> { ::Elevenlabs::Types::CaptionStyleWordAnimationModelEnterType }, optional: false, nullable: false
      field :exit_type, -> { ::Elevenlabs::Types::CaptionStyleWordAnimationModelExitType }, optional: false, nullable: false

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
