# frozen_string_literal: true

module Elevenlabs
  module Types
    module RagIndexStatus
      extend ::Elevenlabs::Internal::Types::Enum

      NEW = :new
      CREATED = :created
      PROCESSING = :processing
      FAILED = :failed
      SUCCEEDED = :succeeded
      RAG_LIMIT_EXCEEDED = :rag_limit_exceeded
      DOCUMENT_TOO_SMALL = :document_too_small
      CANNOT_INDEX_FOLDER = :cannot_index_folder

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
