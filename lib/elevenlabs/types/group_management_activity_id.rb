# frozen_string_literal: true

module Elevenlabs
  module Types
    module GroupManagementActivityID
      extend ::Elevenlabs::Internal::Types::Enum

      V0 = 0
      V1 = 1
      V2 = 2
      V3 = 3
      V4 = 4
      V5 = 5
      V6 = 6
      V7 = 7
      V8 = 8
      V9 = 9
      V99 = 99

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
