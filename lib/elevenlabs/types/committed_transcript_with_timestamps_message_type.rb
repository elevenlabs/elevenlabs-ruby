# frozen_string_literal: true

module Elevenlabs
  module Types
    module CommittedTranscriptWithTimestampsMessageType
      extend ::Elevenlabs::Internal::Types::Enum

      COMMITTED_TRANSCRIPT_WITH_TIMESTAMPS = :committed_transcript_with_timestamps

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
