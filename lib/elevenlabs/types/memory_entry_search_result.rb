# frozen_string_literal: true

module Elevenlabs
  module Types
    class MemoryEntrySearchResult < ::Elevenlabs::Internal::Types::Model
      field :entry_id, -> { String }, optional: false, nullable: false
      field :version, -> { Integer }, optional: false, nullable: false
      field :summary, -> { String }, optional: true, nullable: true
      field :text, -> { String }, optional: true, nullable: true
      field :source, -> { ::Elevenlabs::Types::MemoryEntrySearchResultSource }, optional: true, nullable: true

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
