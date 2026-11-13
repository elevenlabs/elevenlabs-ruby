# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowUpdateStateNodeModelInput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::WorkflowUpdateStateNodeModelInputType }, optional: true, nullable: false
      field :position, -> { ::Elevenlabs::Types::PositionInput }, optional: true, nullable: false
      field :edge_order, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :label, -> { String }, optional: false, nullable: false
      field :updates, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WorkflowStateUpdateInput] }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(updates, 'updates', max_items: 50)
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
