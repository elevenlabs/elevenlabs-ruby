# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Documents
        module Types
          module UpdateDocumentsResponse
            extend ::Elevenlabs::Internal::Types::Union

            discriminant :type
            member -> { ::Elevenlabs::Types::GetKnowledgeBaseURLResponseModel }, key: 'url'
            member -> { ::Elevenlabs::Types::GetKnowledgeBaseFileResponseModel }, key: 'file'
            member -> { ::Elevenlabs::Types::GetKnowledgeBaseTextResponseModel }, key: 'text'
            member -> { ::Elevenlabs::Types::GetKnowledgeBaseFolderResponseModel }, key: 'folder'

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
    end
  end
end
