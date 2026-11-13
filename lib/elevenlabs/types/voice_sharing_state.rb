# frozen_string_literal: true

module Elevenlabs
  module Types
    module VoiceSharingState
      extend ::Elevenlabs::Internal::Types::Enum

      ENABLED = :enabled
      DISABLED = :disabled
      COPIED = :copied
      COPIED_DISABLED = :copied_disabled

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
