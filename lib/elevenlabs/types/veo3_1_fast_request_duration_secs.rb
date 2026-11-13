# frozen_string_literal: true

module Elevenlabs
  module Types
    module Veo31FastRequestDurationSecs
      extend ::Elevenlabs::Internal::Types::Enum

      V4 = 4
      V6 = 6
      V8 = 8

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
