# frozen_string_literal: true

module Elevenlabs
  module Types
    class CommittedTranscriptWithTimestamps < ::Elevenlabs::Internal::Types::Model
      field :message_type, -> { ::Elevenlabs::Types::CommittedTranscriptWithTimestampsMessageType }, optional: true, nullable: false
      field :text, -> { String }, optional: false, nullable: false
      field :language_code, -> { String }, optional: true, nullable: true
      field :words, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::CommittedTranscriptWithTimestampsWordsItem] }, optional: true, nullable: true

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
