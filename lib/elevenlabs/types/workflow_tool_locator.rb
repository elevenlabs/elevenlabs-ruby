# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowToolLocator < ::Elevenlabs::Internal::Types::Model
      field :tool_id, -> { String }, optional: false, nullable: false
      field :schema_overrides, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::Types::WorkflowToolLocatorSchemaOverridesValue] }, optional: true, nullable: true

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
