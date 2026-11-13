# frozen_string_literal: true

module Elevenlabs
  module Types
    class UserTranscript < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::UserTranscriptType }, optional: false, nullable: false
      field :event_id, -> { Integer }, optional: false, nullable: false
      field :user_transcript, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::UserTranscriptUserTranscriptItem] }, optional: false, nullable: false

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
