# frozen_string_literal: true

module Elevenlabs
  module Types
    class ToolUsageStatsResponseModel < ::Elevenlabs::Internal::Types::Model
      field :total_calls, -> { Integer }, optional: true, nullable: false
      field :avg_latency_secs, -> { Float }, optional: false, nullable: false

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
