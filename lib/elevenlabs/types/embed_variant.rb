# frozen_string_literal: true

module Elevenlabs
  module Types
    module EmbedVariant
      extend ::Elevenlabs::Internal::Types::Enum

      TINY = :tiny
      COMPACT = :compact
      FULL = :full
      EXPANDABLE = :expandable

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
