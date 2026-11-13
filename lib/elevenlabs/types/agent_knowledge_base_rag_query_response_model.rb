# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentKnowledgeBaseRagQueryResponseModel < ::Elevenlabs::Internal::Types::Model
      field :strategy, -> { ::Elevenlabs::Types::SearchStrategy }, optional: false, nullable: false
      field :retrieval_query, -> { String }, optional: false, nullable: true
      field :chunks, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AgentKnowledgeBaseRagChunkResponseModel] }, optional: false, nullable: false
      field :document, -> { ::Elevenlabs::Types::AgentKnowledgeBaseRagDocumentResponseModel }, optional: true, nullable: false
      field :listing, -> { ::Elevenlabs::Types::AgentKnowledgeBaseRagListingResponseModel }, optional: true, nullable: false

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
