# frozen_string_literal: true

module Elevenlabs
  module Types
    class LlmInputOutputTokensUsage < ::Elevenlabs::Internal::Types::Model
      field :input, -> { ::Elevenlabs::Types::LlmTokensCategoryUsage }, optional: true, nullable: false
      field :input_cache_read, -> { ::Elevenlabs::Types::LlmTokensCategoryUsage }, optional: true, nullable: false
      field :input_cache_write, -> { ::Elevenlabs::Types::LlmTokensCategoryUsage }, optional: true, nullable: false
      field :output_total, -> { ::Elevenlabs::Types::LlmTokensCategoryUsage }, optional: true, nullable: false

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
