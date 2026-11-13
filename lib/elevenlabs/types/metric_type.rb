# frozen_string_literal: true

module Elevenlabs
  module Types
    module MetricType
      extend ::Elevenlabs::Internal::Types::Enum

      CREDITS = :credits
      TTS_CHARACTERS = :tts_characters
      MINUTES_USED = :minutes_used
      REQUEST_COUNT = :request_count
      TTFB_AVG = :ttfb_avg
      TTFB_P95 = :ttfb_p95
      FIAT_UNITS_SPENT = :fiat_units_spent
      CONCURRENCY = :concurrency
      CONCURRENCY_AVERAGE = :concurrency_average

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
