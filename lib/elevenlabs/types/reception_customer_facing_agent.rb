# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionCustomerFacingAgent < ::Elevenlabs::Internal::Types::Model
      field :agent_id, -> { String }, optional: true, nullable: false
      field :config, -> { ::Elevenlabs::Types::ReceptionCustomerFacingConfigInput }, optional: true, nullable: false
      field :deactivated_at_unix, -> { Integer }, optional: true, nullable: true
      field :deactivation_reason, -> { ::Elevenlabs::Types::ReceptionCustomerFacingAgentDeactivationReason }, optional: true, nullable: false

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
