# frozen_string_literal: true

module Elevenlabs
  module Types
    module TurnDetectionType
      extend ::Elevenlabs::Internal::Types::Enum

      SEMANTIC_VAD = :semantic_vad
      SERVER_VAD = :server_vad

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
