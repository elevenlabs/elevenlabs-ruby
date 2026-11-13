# frozen_string_literal: true

module Elevenlabs
  module Types
    module LlmReasoningEffort
      extend ::Elevenlabs::Internal::Types::Enum

      NONE = :none
      MINIMAL = :minimal
      LOW = :low
      MEDIUM = :medium
      HIGH = :high
      XHIGH = :xhigh
      MAX = :max

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
