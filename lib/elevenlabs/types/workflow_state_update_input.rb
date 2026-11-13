# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowStateUpdateInput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::WorkflowStateUpdateInputType }, optional: true, nullable: false
      field :variable_name, -> { String }, optional: false, nullable: false
      field :expression, -> { ::Elevenlabs::Types::AstNodeInput }, optional: false, nullable: false
      field :required, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
