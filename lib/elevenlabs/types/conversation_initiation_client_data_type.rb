# frozen_string_literal: true

module Elevenlabs
  module Types
    module ConversationInitiationClientDataType
      extend ::Elevenlabs::Internal::Types::Enum

      CONVERSATION_INITIATION_CLIENT_DATA = :conversation_initiation_client_data

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
