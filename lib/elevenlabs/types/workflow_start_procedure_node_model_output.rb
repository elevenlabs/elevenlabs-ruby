# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowStartProcedureNodeModelOutput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::WorkflowStartProcedureNodeModelOutputType }, optional: false, nullable: false
      field :position, -> { ::Elevenlabs::Types::PositionOutput }, optional: false, nullable: false
      field :edge_order, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :procedure_id, -> { String }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(procedure_id, 'procedure_id', min_length: 1)
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
