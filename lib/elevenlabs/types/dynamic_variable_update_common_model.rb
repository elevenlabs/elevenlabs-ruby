# frozen_string_literal: true

module Elevenlabs
  module Types
    class DynamicVariableUpdateCommonModel < ::Elevenlabs::Internal::Types::Model
      field :variable_name, -> { String }, optional: false, nullable: false
      field :old_value, -> { String }, optional: false, nullable: true
      field :new_value, -> { String }, optional: false, nullable: false
      field :updated_at, -> { Float }, optional: false, nullable: false
      field :tool_name, -> { String }, optional: false, nullable: false
      field :tool_request_id, -> { String }, optional: false, nullable: false

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
