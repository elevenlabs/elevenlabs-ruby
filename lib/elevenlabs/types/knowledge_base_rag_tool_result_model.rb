# frozen_string_literal: true

module Elevenlabs
  module Types
    class KnowledgeBaseRagToolResultModel < ::Elevenlabs::Internal::Types::Model
      field :result_type, -> { ::Elevenlabs::Types::KnowledgeBaseRagToolResultModelResultType }, optional: true, nullable: false
      field :status, -> { ::Elevenlabs::Types::KnowledgeBaseRagToolStatus }, optional: true, nullable: false
      field :chunk_count, -> { Integer }, optional: true, nullable: false
      field :message, -> { String }, optional: true, nullable: false
      field :chunks, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::KnowledgeBaseRagChunkModel] }, optional: true, nullable: false

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
