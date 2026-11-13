# frozen_string_literal: true

module Elevenlabs
  module Types
    class WidgetLanguagePresetResponse < ::Elevenlabs::Internal::Types::Model
      field :first_message, -> { String }, optional: true, nullable: true
      field :text_contents, -> { ::Elevenlabs::Types::WidgetTextContents }, optional: true, nullable: false
      field :terms_text, -> { String }, optional: true, nullable: true
      field :terms_html, -> { String }, optional: true, nullable: true
      field :terms_key, -> { String }, optional: true, nullable: true

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
