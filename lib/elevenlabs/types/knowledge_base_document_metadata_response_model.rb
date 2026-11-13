# frozen_string_literal: true

module Elevenlabs
  module Types
    class KnowledgeBaseDocumentMetadataResponseModel < ::Elevenlabs::Internal::Types::Model
      field :created_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :last_updated_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :size_bytes, -> { Integer }, optional: false, nullable: false

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
