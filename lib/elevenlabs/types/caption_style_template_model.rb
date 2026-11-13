# frozen_string_literal: true

module Elevenlabs
  module Types
    class CaptionStyleTemplateModel < ::Elevenlabs::Internal::Types::Model
      field :key, -> { String }, optional: false, nullable: false
      field :label, -> { String }, optional: false, nullable: false
      field :requires_high_fps, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
