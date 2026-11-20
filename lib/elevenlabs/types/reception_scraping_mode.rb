# frozen_string_literal: true

module Elevenlabs
  module Types
    module ReceptionScrapingMode
      extend ::Elevenlabs::Internal::Types::Enum

      SINGLE_PAGE = :single_page
      DEEP_SCAN = :deep_scan
      QUICK_SCAN = :quick_scan

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
