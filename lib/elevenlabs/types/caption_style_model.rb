# frozen_string_literal: true

module Elevenlabs
  module Types
    class CaptionStyleModel < ::Elevenlabs::Internal::Types::Model
      field :template, -> { ::Elevenlabs::Types::CaptionStyleTemplateModel }, optional: true, nullable: true
      field :text_font, -> { String }, optional: true, nullable: true
      field :text_scale, -> { Float }, optional: true, nullable: true
      field :text_color, -> { String }, optional: true, nullable: true
      field :text_align, -> { ::Elevenlabs::Types::CaptionStyleModelTextAlign }, optional: true, nullable: true
      field :text_style, -> { ::Elevenlabs::Types::CaptionStyleModelTextStyle }, optional: true, nullable: true
      field :text_weight, -> { ::Elevenlabs::Types::CaptionStyleModelTextWeight }, optional: true, nullable: true
      field :text_transform, -> { ::Elevenlabs::Types::CaptionStyleModelTextTransform }, optional: true, nullable: true
      field :text_blend_mode, -> { ::Elevenlabs::Types::CaptionStyleModelTextBlendMode }, optional: true, nullable: true
      field :text_shadow, -> { ::Elevenlabs::Types::StudioTextStyleShadowModel }, optional: true, nullable: true
      field :text_outline, -> { ::Elevenlabs::Types::StudioTextStyleOutlineModel }, optional: true, nullable: true
      field :background_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :background_color, -> { String }, optional: true, nullable: true
      field :background_opacity, -> { Float }, optional: true, nullable: true
      field :background_blur, -> { Float }, optional: true, nullable: true
      field :background_border_radius, -> { Float }, optional: true, nullable: true
      field :word_highlights_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :word_highlights_color, -> { String }, optional: true, nullable: true
      field :word_highlights_background_color, -> { String }, optional: true, nullable: true
      field :word_highlights_opacity, -> { Float }, optional: true, nullable: true
      field :word_highlights_border_radius, -> { Float }, optional: true, nullable: true
      field :word_highlights_blur, -> { Float }, optional: true, nullable: true
      field :section_animation, -> { ::Elevenlabs::Types::CaptionStyleSectionAnimationModel }, optional: true, nullable: true
      field :word_animation, -> { ::Elevenlabs::Types::CaptionStyleWordAnimationModel }, optional: true, nullable: true
      field :character_animation, -> { ::Elevenlabs::Types::CaptionStyleCharacterAnimationModel }, optional: true, nullable: true
      field :cursor_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :width_pct, -> { Float }, optional: true, nullable: true
      field :horizontal_placement, -> { ::Elevenlabs::Types::CaptionStyleHorizontalPlacementModel }, optional: true, nullable: true
      field :vertical_placement, -> { ::Elevenlabs::Types::CaptionStyleVerticalPlacementModel }, optional: true, nullable: true
      field :auto_break_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :max_lines_per_section, -> { Integer }, optional: true, nullable: true
      field :max_words_per_line, -> { Integer }, optional: true, nullable: true

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
