# frozen_string_literal: true

module Elevenlabs
  module Types
    class RagConfigWorkflowOverrideOutput < ::Elevenlabs::Internal::Types::Model
      field :enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :embedding_model, -> { ::Elevenlabs::Types::EmbeddingModelEnum }, optional: true, nullable: false
      field :max_vector_distance, -> { Float }, optional: true, nullable: true
      field :max_documents_length, -> { Integer }, optional: true, nullable: true
      field :max_retrieved_rag_chunks_count, -> { Integer }, optional: true, nullable: true
      field :num_candidates, -> { Integer }, optional: true, nullable: true
      field :query_rewrite_prompt_override, -> { String }, optional: true, nullable: true
      field :knowledge_base_tool_info, -> { ::Elevenlabs::Types::KnowledgeBaseToolInfo }, optional: true, nullable: false

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
