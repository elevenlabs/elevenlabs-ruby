# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationHistoryRedactionConfig < ::Elevenlabs::Internal::Types::Model
      field :enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :entities, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConfigEntityType] }, optional: true, nullable: false
      field :excluded_data_collection_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(excluded_data_collection_ids, 'excluded_data_collection_ids', max_items: 50)
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
