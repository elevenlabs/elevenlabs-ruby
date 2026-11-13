# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConvAiStoredSecretDependencies < ::Elevenlabs::Internal::Types::Model
      field :tools, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConvAiStoredSecretDependenciesToolsItem] }, optional: false, nullable: false
      field :tools_has_more, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :agents, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConvAiStoredSecretDependenciesAgentsItem] }, optional: false, nullable: false
      field :agents_has_more, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :phone_numbers, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DependentPhoneNumberIdentifier] }, optional: true, nullable: false
      field :phone_numbers_has_more, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :mcp_servers, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConvAiStoredSecretDependenciesMcpServersItem] }, optional: true, nullable: false
      field :others, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::SecretDependencyType] }, optional: false, nullable: false

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
