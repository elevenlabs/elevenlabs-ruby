# frozen_string_literal: true

module Elevenlabs
  module Types
    module ToolInterruptionMode
      extend ::Elevenlabs::Internal::Types::Enum

      ALLOW = :allow
      DISABLE_DURING_TOOL = :disable_during_tool
      DISABLE_DURING_TOOL_AND_TURN = :disable_during_tool_and_turn

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
