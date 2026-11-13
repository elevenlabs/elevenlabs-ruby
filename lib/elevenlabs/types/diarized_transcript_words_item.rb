# frozen_string_literal: true

module Elevenlabs
  module Types
    class DiarizedTranscriptWordsItem < ::Elevenlabs::Internal::Types::Model
      field :text, -> { String }, optional: false, nullable: false
      field :start, -> { Float }, optional: true, nullable: true
      field :end_, -> { Float }, optional: true, nullable: true, api_name: 'end'
      field :type, -> { ::Elevenlabs::Types::SpeechToTextWordResponseModelType }, optional: false, nullable: false
      field :speaker_id, -> { String }, optional: true, nullable: true
      field :logprob, -> { Float }, optional: false, nullable: false
      field :characters, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DiarizedTranscriptWordsItemCharactersItem] }, optional: true, nullable: true
      field :channel_index, -> { Integer }, optional: true, nullable: true

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
