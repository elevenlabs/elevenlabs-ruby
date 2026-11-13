# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkspaceAnalyticsQueryResponseModel < ::Elevenlabs::Internal::Types::Model
      field :columns, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :column_types, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WorkspaceAnalyticsQueryResponseModelColumnTypesItem] }, optional: false, nullable: false
      field :rows, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WorkspaceAnalyticsQueryResponseModelRowsItemItem]] }, optional: false, nullable: false
      field :column_units, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ColumnUnit] }, optional: false, nullable: false

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
