# frozen_string_literal: true

module Elevenlabs
  module Types
    module ProjectState
      extend ::Elevenlabs::Internal::Types::Enum

      CREATING = :creating
      DEFAULT = :default
      CONVERTING = :converting
      IN_QUEUE = :in_queue

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
