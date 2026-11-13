# frozen_string_literal: true

module Elevenlabs
  module Types
    class DependentAvailableAgentIdentifier < ::Elevenlabs::Internal::Types::Model
      field :referenced_resource_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :type, -> { ::Elevenlabs::Types::DependentAvailableAgentIdentifierType }, optional: true, nullable: false
      field :created_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :access_level, -> { ::Elevenlabs::Types::DependentAvailableAgentIdentifierAccessLevel }, optional: false, nullable: false

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
