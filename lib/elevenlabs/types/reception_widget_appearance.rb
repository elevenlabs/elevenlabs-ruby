# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionWidgetAppearance < ::Elevenlabs::Internal::Types::Model
      field :orb_color1, -> { String }, optional: false, nullable: false, api_name: 'orb_color_1'
      field :orb_color2, -> { String }, optional: false, nullable: false, api_name: 'orb_color_2'
      field :variant, -> { ::Elevenlabs::Types::ReceptionWidgetAppearanceVariant }, optional: false, nullable: false
      field :placement, -> { ::Elevenlabs::Types::ReceptionWidgetAppearancePlacement }, optional: false, nullable: false
      field :dismissible, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :main_label, -> { String }, optional: true, nullable: true
      field :start_call, -> { String }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_string!(orb_color1, 'orb_color_1', pattern: /^#(?:[0-9a-fA-F]{3}|[0-9a-fA-F]{6})$/)
        ::Elevenlabs::Validator.validate_string!(orb_color2, 'orb_color_2', pattern: /^#(?:[0-9a-fA-F]{3}|[0-9a-fA-F]{6})$/)
        ::Elevenlabs::Validator.validate_string!(main_label, 'main_label', max_length: 100)
        ::Elevenlabs::Validator.validate_string!(start_call, 'start_call', max_length: 100)
      end

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
