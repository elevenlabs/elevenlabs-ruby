# frozen_string_literal: true

module Elevenlabs
  module Types
    class MusicExploreSongSourceContext < ::Elevenlabs::Internal::Types::Model
      field :source_type, -> { ::Elevenlabs::Types::MusicExploreSongSourceContextSourceType }, optional: true, nullable: false
      field :music_explore_song_id, -> { String }, optional: false, nullable: false
      field :title, -> { String }, optional: true, nullable: true
      field :description, -> { String }, optional: true, nullable: true
      field :bpm, -> { Integer }, optional: true, nullable: true
      field :vocals, -> { String }, optional: true, nullable: true
      field :lyrics, -> { String }, optional: true, nullable: true

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
