# frozen_string_literal: true

module Elevenlabs
  module Types
    class CampaignConfigOutput < ::Elevenlabs::Internal::Types::Model
      field :policy, -> { ::Elevenlabs::Types::PolicyConfigOutput }, optional: true, nullable: false
      field :agent_policies, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::AgentPolicyOverrideOutput] }, optional: true, nullable: false
      field :whatsapp_voice_policy, -> { ::Elevenlabs::Types::AgentPolicyOverrideOutput }, optional: true, nullable: false

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
