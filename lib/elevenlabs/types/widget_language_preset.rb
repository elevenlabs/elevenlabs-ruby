# frozen_string_literal: true

module Elevenlabs
  module Types
    class WidgetLanguagePreset < ::Elevenlabs::Internal::Types::Model
      field :text_contents, -> { ::Elevenlabs::Types::WidgetTextContents }, optional: true, nullable: false
      field :text_contents_translation, -> { ::Elevenlabs::Types::WidgetTextContentsTranslation }, optional: true, nullable: true
      field :terms_text, -> { String }, optional: true, nullable: true
      field :terms_html, -> { String }, optional: true, nullable: true
      field :terms_key, -> { String }, optional: true, nullable: true
      field :terms_translation, -> { ::Elevenlabs::Types::WidgetTermsTranslation }, optional: true, nullable: true

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
