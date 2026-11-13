# frozen_string_literal: true

module Elevenlabs
  module Types
    class AuthConnectionDependencies < ::Elevenlabs::Internal::Types::Model
      field :tools, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AuthConnectionDependenciesToolsItem] }, optional: true, nullable: false
      field :mcp_servers, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AuthConnectionDependenciesMcpServersItem] }, optional: true, nullable: false
      field :integration_connections, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DependentIntegrationConnectionIdentifier] }, optional: true, nullable: false

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
