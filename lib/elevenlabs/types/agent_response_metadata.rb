# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentResponseMetadata < ::Elevenlabs::Internal::Types::Model
      field :agent_response_metadata_event, -> { ::Elevenlabs::Types::AgentResponseMetadataAgentResponseMetadataEvent }, optional: false, nullable: false
      field :type, -> { ::Elevenlabs::Types::AgentResponseMetadataType }, optional: true, nullable: false

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
