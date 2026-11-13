# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Documents
        module Types
          class BodyBulkMoveEntitiesToFolderV1ConvaiKnowledgeBaseBulkMovePost < ::Elevenlabs::Internal::Types::Model
            field :document_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
            field :move_to, -> { String }, optional: true, nullable: true

            def validate!
              ::Elevenlabs::Validator.validate_array!(document_ids, 'document_ids', min_items: 1, max_items: 20, unique_items: true)
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
    end
  end
end
