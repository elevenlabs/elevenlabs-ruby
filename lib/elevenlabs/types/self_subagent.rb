# frozen_string_literal: true

module Elevenlabs
  module Types
    class SelfSubagent < ::Elevenlabs::Internal::Types::Model
      field :execution_mode, -> { ::Elevenlabs::Types::SelfSubagentExecutionMode }, optional: true, nullable: false
      field :timeout_secs, -> { Integer }, optional: true, nullable: false
      field :description, -> { String }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_integer!(timeout_secs, 'timeout_secs', min: 10, max: 3600)
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
