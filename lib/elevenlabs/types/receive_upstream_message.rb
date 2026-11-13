# frozen_string_literal: true

module Elevenlabs
  module Types
    module ReceiveUpstreamMessage
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::Init }, key: 'init'
      member -> { ::Elevenlabs::Types::UserTranscript }, key: 'user_transcript'
      member -> { ::Elevenlabs::Types::Ping }, key: 'ping'
      member -> { ::Elevenlabs::Types::Close }, key: 'close'
      member -> { ::Elevenlabs::Types::SpeechEngineError }, key: 'error'

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
