# frozen_string_literal: true

module Elevenlabs
  module Types
    class RagRetrievalInfo < ::Elevenlabs::Internal::Types::Model
      field :chunks, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::RagChunkMetadata] }, optional: false, nullable: false
      field :embedding_model, -> { ::Elevenlabs::Types::EmbeddingModelEnum }, optional: false, nullable: false
      field :retrieval_query, -> { String }, optional: false, nullable: false
      field :rag_latency_secs, -> { Float }, optional: false, nullable: false
      field :used_chunk_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false

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
