# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Documents
        module Types
          class BodyCreateFileDocumentV1ConvaiKnowledgeBaseFilePost < ::Elevenlabs::Internal::Types::Model
            field :file, -> { String }, optional: false, nullable: false
            field :name, -> { String }, optional: true, nullable: true
            field :parent_folder_id, -> { String }, optional: true, nullable: true

            def validate!
              ::Elevenlabs::Validator.validate_string!(name, 'name', min_length: 1)
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
