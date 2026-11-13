# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Documents
        module Types
          class BodyCreateURLDocumentV1ConvaiKnowledgeBaseURLPost < ::Elevenlabs::Internal::Types::Model
            field :url, -> { String }, optional: false, nullable: false
            field :name, -> { String }, optional: true, nullable: true
            field :parent_folder_id, -> { String }, optional: true, nullable: true
            field :enable_auto_sync, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
            field :auto_remove, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
            field :minimum_frequency_days, -> { Integer }, optional: true, nullable: true

            def validate!
              ::Elevenlabs::Validator.validate_string!(name, 'name', min_length: 1)
              ::Elevenlabs::Validator.validate_integer!(minimum_frequency_days, 'minimum_frequency_days', min: 1, max: 180)
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
