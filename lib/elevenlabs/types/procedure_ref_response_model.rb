# frozen_string_literal: true

module Elevenlabs
  module Types
    class ProcedureRefResponseModel < ::Elevenlabs::Internal::Types::Model
      field :procedure_id, -> { String }, optional: false, nullable: false
      field :version_id, -> { String }, optional: true, nullable: true
      field :name, -> { String }, optional: true, nullable: false
      field :type, -> { ::Elevenlabs::Types::ProcedureType }, optional: true, nullable: false
      field :trigger, -> { String }, optional: true, nullable: false
      field :referenced_tool_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :referenced_kb_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :referenced_procedure_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :referenced_dynamic_variables, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :folder_parent_id, -> { String }, optional: true, nullable: true

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
