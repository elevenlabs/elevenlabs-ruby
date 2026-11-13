# frozen_string_literal: true

module Elevenlabs
  module Types
    module WorkspaceAnalyticsQueryResponseModelColumnTypesItem
      extend ::Elevenlabs::Internal::Types::Enum

      STRING = :String
      FLOAT = :Float
      DATE_TIME = :DateTime
      INT = :Int
      BOOL = :Bool
      JSON = :JSON
      MAP = :Map
      ARRAY = :Array

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
