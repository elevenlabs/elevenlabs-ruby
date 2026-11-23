# frozen_string_literal: true

module Elevenlabs
  module Types
    module AgentToolRequestType
      extend ::Elevenlabs::Internal::Types::Enum

      AGENT_TOOL_REQUEST = :agent_tool_request

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
