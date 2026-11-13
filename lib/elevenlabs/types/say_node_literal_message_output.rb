# frozen_string_literal: true

module Elevenlabs
  module Types
    class SayNodeLiteralMessageOutput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::SayNodeLiteralMessageOutputType }, optional: false, nullable: false
      field :text, -> { String }, optional: false, nullable: false
      field :text_translations, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::TranslatedString] }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(text, 'text', min_length: 1)
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
