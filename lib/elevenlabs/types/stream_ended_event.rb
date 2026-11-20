# frozen_string_literal: true

module Elevenlabs
  module Types
    class StreamEndedEvent < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::StreamEndedEventType }, optional: true, nullable: false
      field :stream_ended_event, -> { ::Elevenlabs::Types::StreamEndedData }, optional: false, nullable: false

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
