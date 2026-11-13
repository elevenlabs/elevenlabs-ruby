# frozen_string_literal: true

module Elevenlabs
  module Types
    module ChapterContentBlockInputModelSubType
      extend ::Elevenlabs::Internal::Types::Enum

      P = :p
      H1 = :h1
      H2 = :h2
      H3 = :h3

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
