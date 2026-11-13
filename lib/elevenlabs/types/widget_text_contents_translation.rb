# frozen_string_literal: true

module Elevenlabs
  module Types
    class WidgetTextContentsTranslation < ::Elevenlabs::Internal::Types::Model
      field :source, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :text, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false

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
