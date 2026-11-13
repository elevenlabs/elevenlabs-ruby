# frozen_string_literal: true

module Elevenlabs
  module Types
    class SessionStarted < ::Elevenlabs::Internal::Types::Model
      field :message_type, -> { ::Elevenlabs::Types::SessionStartedMessageType }, optional: true, nullable: false
      field :session_id, -> { String }, optional: false, nullable: false
      field :config, -> { ::Elevenlabs::Types::SessionStartedConfig }, optional: false, nullable: false

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
