# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentKnowledgeBaseRagDocumentResponseModel < ::Elevenlabs::Internal::Types::Model
      field :document_id, -> { String }, optional: false, nullable: false
      field :document_name, -> { String }, optional: false, nullable: false
      field :source_url, -> { String }, optional: false, nullable: true
      field :content, -> { String }, optional: false, nullable: false
      field :truncated, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :content_format, -> { ::Elevenlabs::Types::ContentFormat }, optional: false, nullable: false
      field :document_type, -> { ::Elevenlabs::Types::KnowledgeBaseDocumentType }, optional: false, nullable: false

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
