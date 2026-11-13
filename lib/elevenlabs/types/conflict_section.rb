# frozen_string_literal: true

module Elevenlabs
  module Types
    module ConflictSection
      extend ::Elevenlabs::Internal::Types::Enum

      CONVERSATION_CONFIG = :conversation_config
      PLATFORM_SETTINGS = :platform_settings
      PROCEDURES = :procedures
      WORKFLOW = :workflow

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
