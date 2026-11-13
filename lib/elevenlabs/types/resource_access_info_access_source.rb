# frozen_string_literal: true

module Elevenlabs
  module Types
    module ResourceAccessInfoAccessSource
      extend ::Elevenlabs::Internal::Types::Enum

      CREATOR = :creator
      EXPLICIT = :explicit
      WORKSPACE_ADMIN = :workspace_admin
      WORKSPACE_DEFAULT = :workspace_default

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
