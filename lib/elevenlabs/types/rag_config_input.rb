# frozen_string_literal: true

module Elevenlabs
  module Types
    class RagConfigInput < ::Elevenlabs::Internal::Types::Model
      field :enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :embedding_model, -> { ::Elevenlabs::Types::EmbeddingModelEnum }, optional: true, nullable: false
      field :max_vector_distance, -> { Float }, optional: true, nullable: false
      field :max_documents_length, -> { Integer }, optional: true, nullable: false
      field :max_retrieved_rag_chunks_count, -> { Integer }, optional: true, nullable: false
      field :num_candidates, -> { Integer }, optional: true, nullable: true
      field :query_rewrite_prompt_override, -> { String }, optional: true, nullable: true
      field :knowledge_base_tool_info, -> { ::Elevenlabs::Types::KnowledgeBaseToolInfo }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_integer!(max_retrieved_rag_chunks_count, 'max_retrieved_rag_chunks_count', max: 20)
        ::Elevenlabs::Validator.validate_integer!(num_candidates, 'num_candidates', max: 10_000)
        ::Elevenlabs::Validator.validate_string!(query_rewrite_prompt_override, 'query_rewrite_prompt_override', min_length: 1, max_length: 1000)
      end

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
