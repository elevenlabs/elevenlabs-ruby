# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentResponseCorrectionAgentResponseCorrectionEvent < ::Elevenlabs::Internal::Types::Model
      field :original_agent_response, -> { String }, optional: false, nullable: false
      field :corrected_agent_response, -> { String }, optional: false, nullable: false
      field :event_id, -> { Integer }, optional: false, nullable: false
      field :response_id, -> { String }, optional: false, nullable: false

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
