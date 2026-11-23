# frozen_string_literal: true

module Elevenlabs
  module Types
    class McpConnectionStatusMcpConnectionStatusIntegrationsItem < ::Elevenlabs::Internal::Types::Model
      field :integration_id, -> { String }, optional: false, nullable: false
      field :integration_type, -> { ::Elevenlabs::Types::McpConnectionStatusMcpConnectionStatusIntegrationsItemIntegrationType }, optional: false, nullable: false
      field :is_connected, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :tool_count, -> { Integer }, optional: true, nullable: false

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
