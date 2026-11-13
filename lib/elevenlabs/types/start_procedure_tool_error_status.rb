# frozen_string_literal: true

module Elevenlabs
  module Types
    module StartProcedureToolErrorStatus
      extend ::Elevenlabs::Internal::Types::Enum

      NOT_FOUND = :not_found
      INVALID_NAME = :invalid_name
      ALREADY_ACTIVE = :already_active

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
