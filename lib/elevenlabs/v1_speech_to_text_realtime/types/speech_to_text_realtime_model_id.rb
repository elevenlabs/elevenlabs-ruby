# frozen_string_literal: true

module Elevenlabs
  module V1SpeechToTextRealtime
    module Types
      module SpeechToTextRealtimeModelID
        extend ::Elevenlabs::Internal::Types::Enum

        SCRIBE_V2_REALTIME = :scribe_v2_realtime
        SCRIBE_V3_LIVE = :scribe_v3_live

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
end
