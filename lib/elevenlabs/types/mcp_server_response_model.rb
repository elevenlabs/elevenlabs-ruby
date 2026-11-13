# frozen_string_literal: true

module Elevenlabs
  module Types
    class McpServerResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :config, -> { ::Elevenlabs::Types::McpServerConfigOutput }, optional: false, nullable: false
      field :access_info, -> { ::Elevenlabs::Types::ResourceAccessInfo }, optional: true, nullable: false
      field :dependent_agents, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::McpServerResponseModelDependentAgentsItem] }, optional: true, nullable: false
      field :metadata, -> { ::Elevenlabs::Types::McpServerMetadataResponseModel }, optional: false, nullable: false

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
