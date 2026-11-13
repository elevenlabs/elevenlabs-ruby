# frozen_string_literal: true

module Elevenlabs
  module Types
    class StudioTextStyleShadowModel < ::Elevenlabs::Internal::Types::Model
      field :enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :color, -> { String }, optional: false, nullable: false
      field :opacity, -> { Float }, optional: false, nullable: false
      field :blur, -> { Float }, optional: false, nullable: false
      field :offset_x, -> { Float }, optional: false, nullable: false
      field :offset_y, -> { Float }, optional: false, nullable: false

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
