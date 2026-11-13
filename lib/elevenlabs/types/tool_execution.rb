# frozen_string_literal: true

module Elevenlabs
  module Types
    class ToolExecution < ::Elevenlabs::Internal::Types::Model
      field :task_support, -> { ::Elevenlabs::Types::ToolExecutionTaskSupport }, optional: true, nullable: true, api_name: 'taskSupport'

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
