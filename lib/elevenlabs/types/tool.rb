# frozen_string_literal: true

module Elevenlabs
  module Types
    class Tool < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :title, -> { String }, optional: true, nullable: true
      field :description, -> { String }, optional: true, nullable: true
      field :input_schema, -> { Object }, optional: false, nullable: false, api_name: 'inputSchema'
      field :execution, -> { ::Elevenlabs::Types::ToolExecution }, optional: true, nullable: true
      field :output_schema, -> { Object }, optional: true, nullable: true, api_name: 'outputSchema'
      field :icons, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::Icon] }, optional: true, nullable: true
      field :annotations, -> { ::Elevenlabs::Types::ToolAnnotations }, optional: true, nullable: true
      field :meta, -> { Object }, optional: true, nullable: true, api_name: '_meta'

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
