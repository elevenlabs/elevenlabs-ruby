# frozen_string_literal: true

module Elevenlabs
  module Types
    class KnowledgeBaseBulkDeleteSuccessfulResponseModel < ::Elevenlabs::Internal::Types::Model
      field :status, -> { ::Elevenlabs::Types::KnowledgeBaseBulkDeleteSuccessfulResponseModelStatus }, optional: false, nullable: false
      field :data, -> { ::Elevenlabs::Types::KnowledgeBaseDeletedResponseModel }, optional: false, nullable: false

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
