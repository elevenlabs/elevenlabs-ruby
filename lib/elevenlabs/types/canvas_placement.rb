# frozen_string_literal: true

module Elevenlabs
  module Types
    class CanvasPlacement < ::Elevenlabs::Internal::Types::Model
      field :x_relative, -> { Float }, optional: true, nullable: false
      field :y_relative, -> { Float }, optional: true, nullable: false
      field :scale_x, -> { Float }, optional: true, nullable: false
      field :scale_y, -> { Float }, optional: true, nullable: false
      field :pivot_x, -> { Float }, optional: true, nullable: false
      field :pivot_y, -> { Float }, optional: true, nullable: false
      field :skew_x, -> { Float }, optional: true, nullable: false
      field :skew_y, -> { Float }, optional: true, nullable: false
      field :crop_top, -> { Float }, optional: true, nullable: false
      field :crop_right, -> { Float }, optional: true, nullable: false
      field :crop_bottom, -> { Float }, optional: true, nullable: false
      field :crop_left, -> { Float }, optional: true, nullable: false
      field :flip_x, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :flip_y, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
