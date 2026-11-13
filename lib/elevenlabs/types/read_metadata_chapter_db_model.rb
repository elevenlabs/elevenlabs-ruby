# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReadMetadataChapterDbModel < ::Elevenlabs::Internal::Types::Model
      field :chapter_name, -> { String }, optional: false, nullable: false
      field :word_count, -> { Integer }, optional: false, nullable: false
      field :char_count, -> { Integer }, optional: false, nullable: false
      field :starting_char_offset, -> { Integer }, optional: false, nullable: false
      field :has_parsed_html, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :has_summary, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :duration_seconds, -> { Float }, optional: true, nullable: true
      field :file_number, -> { String }, optional: true, nullable: true
      field :is_fallback_name, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :chapter_id, -> { String }, optional: true, nullable: true

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
