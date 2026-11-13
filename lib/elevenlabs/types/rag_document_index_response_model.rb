# frozen_string_literal: true

module Elevenlabs
  module Types
    class RagDocumentIndexResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :model, -> { ::Elevenlabs::Types::EmbeddingModelEnum }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::RagIndexStatus }, optional: false, nullable: false
      field :progress_percentage, -> { Float }, optional: false, nullable: false
      field :document_model_index_usage, -> { ::Elevenlabs::Types::RagDocumentIndexUsage }, optional: false, nullable: false

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
