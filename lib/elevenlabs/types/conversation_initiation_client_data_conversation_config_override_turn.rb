# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationInitiationClientDataConversationConfigOverrideTurn < ::Elevenlabs::Internal::Types::Model
      field :soft_timeout_config, -> { ::Elevenlabs::Types::ConversationInitiationClientDataConversationConfigOverrideTurnSoftTimeoutConfig }, optional: true, nullable: false
      field :noisy_environment_message, -> { String }, optional: true, nullable: false

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
