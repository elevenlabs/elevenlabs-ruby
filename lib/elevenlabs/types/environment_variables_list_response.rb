# frozen_string_literal: true

module Elevenlabs
  module Types
    class EnvironmentVariablesListResponse < ::Elevenlabs::Internal::Types::Model
      field :environment_variables, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::EnvironmentVariableResponse] }, optional: false, nullable: false
      field :next_cursor, -> { String }, optional: true, nullable: true
      field :has_more, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
