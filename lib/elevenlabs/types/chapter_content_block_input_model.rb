# frozen_string_literal: true

module Elevenlabs
  module Types
    class ChapterContentBlockInputModel < ::Elevenlabs::Internal::Types::Model
      field :sub_type, -> { ::Elevenlabs::Types::ChapterContentBlockInputModelSubType }, optional: true, nullable: true
      field :nodes, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ChapterContentParagraphTtsNodeInputModel] }, optional: false, nullable: false
      field :block_id, -> { String }, optional: true, nullable: true

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
