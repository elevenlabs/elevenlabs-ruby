# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentToolRequestAgentToolRequest < ::Elevenlabs::Internal::Types::Model
      field :tool_name, -> { String }, optional: false, nullable: false
      field :tool_call_id, -> { String }, optional: false, nullable: false
      field :tool_type, -> { String }, optional: false, nullable: false
      field :event_id, -> { Integer }, optional: false, nullable: false
      field :expects_response, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :disable_interruptions, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :response_timeout_secs, -> { Integer }, optional: false, nullable: false
      field :execution_mode, -> { String }, optional: false, nullable: false

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
