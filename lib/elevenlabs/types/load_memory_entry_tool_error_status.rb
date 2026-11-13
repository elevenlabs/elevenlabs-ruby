# frozen_string_literal: true

module Elevenlabs
  module Types
    module LoadMemoryEntryToolErrorStatus
      extend ::Elevenlabs::Internal::Types::Enum

      NOT_FOUND = :not_found
      INVALID_ID = :invalid_id

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
