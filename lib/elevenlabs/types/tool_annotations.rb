# frozen_string_literal: true

module Elevenlabs
  module Types
    class ToolAnnotations < ::Elevenlabs::Internal::Types::Model
      field :title, -> { String }, optional: true, nullable: true
      field :read_only_hint, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true, api_name: 'readOnlyHint'
      field :destructive_hint, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true, api_name: 'destructiveHint'
      field :idempotent_hint, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true, api_name: 'idempotentHint'
      field :open_world_hint, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true, api_name: 'openWorldHint'

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
