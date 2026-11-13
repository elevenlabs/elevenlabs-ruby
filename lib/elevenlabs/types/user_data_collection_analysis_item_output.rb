# frozen_string_literal: true

module Elevenlabs
  module Types
    class UserDataCollectionAnalysisItemOutput < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :source, -> { ::Elevenlabs::Types::UserDataCollectionAnalysisItemOutputSource }, optional: true, nullable: false
      field :llm, -> { ::Elevenlabs::Types::Llm }, optional: true, nullable: false
      field :kind, -> { ::Elevenlabs::Types::UserDataCollectionAnalysisItemOutputKind }, optional: true, nullable: false
      field :value_schema, -> { ::Elevenlabs::Types::DataCollectionValueSchema }, optional: false, nullable: false

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
