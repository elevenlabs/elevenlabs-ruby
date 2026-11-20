# frozen_string_literal: true

module Elevenlabs
  module Types
    class ResellerWorkspaceOnboardingResponse < ::Elevenlabs::Internal::Types::Model
      field :onboarding_completed_at_unix, -> { Integer }, optional: false, nullable: true
      field :customer_facing_agent_id, -> { String }, optional: false, nullable: false

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
