# frozen_string_literal: true

module Elevenlabs
  module Types
    class DataCollectionResultCommonModel < ::Elevenlabs::Internal::Types::Model
      field :data_collection_id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: true, nullable: true
      field :value, -> { Object }, optional: true, nullable: false
      field :json_schema, -> { ::Elevenlabs::Types::LiteralJSONSchemaProperty }, optional: true, nullable: false
      field :rationale, -> { String }, optional: false, nullable: false

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
