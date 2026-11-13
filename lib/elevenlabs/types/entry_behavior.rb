# frozen_string_literal: true

module Elevenlabs
  module Types
    module EntryBehavior
      extend ::Elevenlabs::Internal::Types::Enum

      GENERATE_IMMEDIATELY = :generate_immediately
      WAIT_FOR_USER = :wait_for_user
      AUTO = :auto

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
