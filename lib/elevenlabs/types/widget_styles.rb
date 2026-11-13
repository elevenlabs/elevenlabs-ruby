# frozen_string_literal: true

module Elevenlabs
  module Types
    class WidgetStyles < ::Elevenlabs::Internal::Types::Model
      field :base, -> { String }, optional: true, nullable: true
      field :base_hover, -> { String }, optional: true, nullable: true
      field :base_active, -> { String }, optional: true, nullable: true
      field :base_border, -> { String }, optional: true, nullable: true
      field :base_subtle, -> { String }, optional: true, nullable: true
      field :base_primary, -> { String }, optional: true, nullable: true
      field :base_error, -> { String }, optional: true, nullable: true
      field :accent, -> { String }, optional: true, nullable: true
      field :accent_hover, -> { String }, optional: true, nullable: true
      field :accent_active, -> { String }, optional: true, nullable: true
      field :accent_border, -> { String }, optional: true, nullable: true
      field :accent_subtle, -> { String }, optional: true, nullable: true
      field :accent_primary, -> { String }, optional: true, nullable: true
      field :overlay_padding, -> { Float }, optional: true, nullable: true
      field :button_radius, -> { Float }, optional: true, nullable: true
      field :input_radius, -> { Float }, optional: true, nullable: true
      field :bubble_radius, -> { Float }, optional: true, nullable: true
      field :sheet_radius, -> { Float }, optional: true, nullable: true
      field :compact_sheet_radius, -> { Float }, optional: true, nullable: true
      field :dropdown_sheet_radius, -> { Float }, optional: true, nullable: true

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
