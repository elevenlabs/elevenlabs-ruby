# frozen_string_literal: true

module Elevenlabs
  module Types
    module ReceiveTextToDialogueWebsocketMessage
      extend ::Elevenlabs::Internal::Types::Union

      member -> { ::Elevenlabs::Types::AudioChunk }
      member -> { ::Elevenlabs::Types::FinalAudioForTurn }
      member -> { ::Elevenlabs::Types::Final }
      member -> { ::Elevenlabs::Types::Error }

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
