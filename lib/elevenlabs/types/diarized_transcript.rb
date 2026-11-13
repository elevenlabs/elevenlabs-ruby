# frozen_string_literal: true

module Elevenlabs
  module Types
    class DiarizedTranscript < ::Elevenlabs::Internal::Types::Model
      field :message_type, -> { ::Elevenlabs::Types::DiarizedTranscriptMessageType }, optional: true, nullable: false
      field :segment_index, -> { Integer }, optional: false, nullable: false
      field :text, -> { String }, optional: false, nullable: false
      field :words, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DiarizedTranscriptWordsItem] }, optional: false, nullable: false

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
