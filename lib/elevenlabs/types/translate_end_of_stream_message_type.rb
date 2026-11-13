# frozen_string_literal: true

module Elevenlabs
  module Types
    module TranslateEndOfStreamMessageType
      extend ::Elevenlabs::Internal::Types::Enum

      END_OF_STREAM = :end_of_stream

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
