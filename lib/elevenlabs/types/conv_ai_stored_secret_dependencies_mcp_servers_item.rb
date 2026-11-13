# frozen_string_literal: true

module Elevenlabs
  module Types
    module ConvAiStoredSecretDependenciesMcpServersItem
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::DependentAvailableMcpServerIdentifier }, key: 'available'
      member -> { ::Elevenlabs::Types::DependentUnknownMcpServerIdentifier }, key: 'unknown'

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
