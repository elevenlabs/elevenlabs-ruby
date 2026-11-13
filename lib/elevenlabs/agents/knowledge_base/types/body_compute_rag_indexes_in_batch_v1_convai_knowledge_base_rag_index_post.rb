# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Types
        class BodyComputeRagIndexesInBatchV1ConvaiKnowledgeBaseRagIndexPost < ::Elevenlabs::Internal::Types::Model
          field :items, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::GetOrCreateRagIndexRequestModel] }, optional: false, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_array!(items, 'items', min_items: 1, max_items: 100)
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
