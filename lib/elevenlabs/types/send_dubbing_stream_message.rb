# frozen_string_literal: true

module Elevenlabs
  module Types
    module SendDubbingStreamMessage
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :message_type
      member -> { ::Elevenlabs::Types::DubbingInputAudioChunk }, key: 'input_audio_chunk'
      member -> { ::Elevenlabs::Types::DubbingEndOfStream }, key: 'end_of_stream'

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
