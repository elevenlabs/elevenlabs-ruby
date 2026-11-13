# frozen_string_literal: true

module Elevenlabs
  module Types
    module BillingPeriod
      extend ::Elevenlabs::Internal::Types::Enum

      MONTHLY_PERIOD = :monthly_period
      V3_MONTH_PERIOD = :'3_month_period'
      V6_MONTH_PERIOD = :'6_month_period'
      ANNUAL_PERIOD = :annual_period

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
