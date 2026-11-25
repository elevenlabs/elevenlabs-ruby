# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationInitiationClientDataConversationConfigOverrideTurnSoftTimeoutConfig < ::Elevenlabs::Internal::Types::Model
      field :message, -> { String }, optional: true, nullable: false
      field :additional_soft_timeout_messages, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false

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
