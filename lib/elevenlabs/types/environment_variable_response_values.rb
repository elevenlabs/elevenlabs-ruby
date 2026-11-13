# frozen_string_literal: true

module Elevenlabs
  module Types
    module EnvironmentVariableResponseValues
      extend ::Elevenlabs::Internal::Types::Union

      member -> { ::Elevenlabs::Internal::Types::Hash[String, String] }
      member -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::EnvironmentVariableSecretValue] }
      member -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::EnvironmentVariableAuthConnectionValue] }

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
