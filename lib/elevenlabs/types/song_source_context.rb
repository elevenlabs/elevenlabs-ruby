# frozen_string_literal: true

module Elevenlabs
  module Types
    class SongSourceContext < ::Elevenlabs::Internal::Types::Model
      field :source_type, -> { ::Elevenlabs::Types::SongSourceContextSourceType }, optional: true, nullable: false
      field :song_id, -> { String }, optional: false, nullable: false
      field :chat_id, -> { String }, optional: true, nullable: true
      field :title, -> { String }, optional: true, nullable: true
      field :description, -> { String }, optional: true, nullable: true
      field :genres, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :languages, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :is_explicit, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :bpm, -> { Integer }, optional: true, nullable: true
      field :generation_settings, -> { Object }, optional: true, nullable: true

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
