# frozen_string_literal: true

module Elevenlabs
  module Types
    module AgentSortBy
      extend ::Elevenlabs::Internal::Types::Enum

      NAME = :name
      CREATED_AT = :created_at
      UPDATED_AT = :updated_at
      CALL_COUNT_7D = :call_count_7d

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
