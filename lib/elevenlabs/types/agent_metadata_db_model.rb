# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentMetadataDbModel < ::Elevenlabs::Internal::Types::Model
      field :created_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :updated_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :created_from, -> { ::Elevenlabs::Types::AgentDefinitionSource }, optional: true, nullable: false
      field :last_updated_from, -> { ::Elevenlabs::Types::AgentDefinitionSource }, optional: true, nullable: false

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
