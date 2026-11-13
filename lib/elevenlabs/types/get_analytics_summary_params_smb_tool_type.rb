# frozen_string_literal: true

module Elevenlabs
  module Types
    module GetAnalyticsSummaryParamsSmbToolType
      extend ::Elevenlabs::Internal::Types::Enum

      GET_ANALYTICS_SUMMARY = :get_analytics_summary

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
