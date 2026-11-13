# frozen_string_literal: true

module Elevenlabs
  module Types
    class PartialTranscript < ::Elevenlabs::Internal::Types::Model
      field :message_type, -> { ::Elevenlabs::Types::PartialTranscriptMessageType }, optional: true, nullable: false
      field :text, -> { String }, optional: false, nullable: false
      field :turn_probability, -> { Float }, optional: true, nullable: true
      field :words, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::PartialTranscriptWordsItem] }, optional: true, nullable: true

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
