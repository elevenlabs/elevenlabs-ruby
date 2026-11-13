# frozen_string_literal: true

module Elevenlabs
  module Types
    module ColumnUnit
      extend ::Elevenlabs::Internal::Types::Enum

      MS = :ms
      S = :s
      MIN = :min
      DURATION = :duration
      CREDITS = :credits
      USD = :usd
      EUR = :eur
      INR = :inr
      PLN = :pln
      GBP = :gbp
      RATIO = :ratio
      RATING = :rating

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
