# frozen_string_literal: true

module Elevenlabs
  module Types
    module UpdateAgentRuleParamsSmbToolType
      extend ::Elevenlabs::Internal::Types::Enum

      UPDATE_AGENT_RULE = :update_agent_rule

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
