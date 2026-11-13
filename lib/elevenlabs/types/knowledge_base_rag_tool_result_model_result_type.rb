# frozen_string_literal: true

module Elevenlabs
  module Types
    module KnowledgeBaseRagToolResultModelResultType
      extend ::Elevenlabs::Internal::Types::Enum

      KNOWLEDGE_BASE_RAG_SUCCESS = :knowledge_base_rag_success

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
