# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tests
      module Types
        class BodyBulkMoveTestsToFolderV1ConvaiAgentTestingBulkMovePost < ::Elevenlabs::Internal::Types::Model
          field :entity_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
          field :move_to, -> { String }, optional: true, nullable: true

          def validate!
            ::Elevenlabs::Validator.validate_array!(entity_ids, 'entity_ids', min_items: 1, unique_items: true)
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
