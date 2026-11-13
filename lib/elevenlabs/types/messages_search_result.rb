# frozen_string_literal: true

module Elevenlabs
  module Types
    class MessagesSearchResult < ::Elevenlabs::Internal::Types::Model
      field :conversation_id, -> { String }, optional: false, nullable: false
      field :agent_id, -> { String }, optional: false, nullable: false
      field :agent_name, -> { String }, optional: true, nullable: true
      field :transcript_index, -> { Integer }, optional: false, nullable: false
      field :chunk_text, -> { String }, optional: false, nullable: false
      field :chunk_highlights, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::SearchHighlightSegment] }, optional: true, nullable: true
      field :score, -> { Float }, optional: false, nullable: false
      field :conversation_start_time_unix_secs, -> { Integer }, optional: false, nullable: false

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
