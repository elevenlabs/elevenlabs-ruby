# frozen_string_literal: true

module Elevenlabs
  module Types
    module KnowledgeBaseContentSearchResultDocument
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::GetKnowledgeBaseSummaryFileResponseModel }, key: 'file'
      member -> { ::Elevenlabs::Types::GetKnowledgeBaseSummaryFolderResponseModel }, key: 'folder'
      member -> { ::Elevenlabs::Types::GetKnowledgeBaseSummaryTextResponseModel }, key: 'text'
      member -> { ::Elevenlabs::Types::GetKnowledgeBaseSummaryURLResponseModel }, key: 'url'

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
