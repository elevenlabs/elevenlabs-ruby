# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentKnowledgeBaseRagQueryRequestModel < ::Elevenlabs::Internal::Types::Model
      field :strategy, -> { ::Elevenlabs::Types::SearchStrategy }, optional: true, nullable: false
      field :query, -> { String }, optional: true, nullable: true
      field :documents, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :use_agent_defaults, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :max_documents_length, -> { Integer }, optional: true, nullable: true
      field :max_retrieved_rag_chunks_count, -> { Integer }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_string!(query, 'query', min_length: 1)
        ::Elevenlabs::Validator.validate_array!(documents, 'documents', max_items: 100)
        ::Elevenlabs::Validator.validate_integer!(max_documents_length, 'max_documents_length', max: 50_000)
        ::Elevenlabs::Validator.validate_integer!(max_retrieved_rag_chunks_count, 'max_retrieved_rag_chunks_count', max: 20)
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
