# frozen_string_literal: true

module Elevenlabs
  module Types
    module AsrProvider
      extend ::Elevenlabs::Internal::Types::Enum

      ELEVENLABS = :elevenlabs
      SCRIBE_REALTIME = :scribe_realtime
      SCRIBE_V2_TURBO = :scribe_v2_turbo

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
