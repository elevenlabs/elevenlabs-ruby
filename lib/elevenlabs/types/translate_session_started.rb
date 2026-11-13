# frozen_string_literal: true

module Elevenlabs
  module Types
    class TranslateSessionStarted < ::Elevenlabs::Internal::Types::Model
      field :message_type, -> { ::Elevenlabs::Types::TranslateSessionStartedMessageType }, optional: false, nullable: false
      field :session_id, -> { String }, optional: false, nullable: false
      field :client_session_id, -> { String }, optional: true, nullable: true

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
