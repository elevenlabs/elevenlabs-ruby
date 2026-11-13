# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConvAiWorkspaceStoredSecretConfig < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::ConvAiWorkspaceStoredSecretConfigType }, optional: false, nullable: false
      field :secret_id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :used_by, -> { ::Elevenlabs::Types::ConvAiStoredSecretDependencies }, optional: false, nullable: false

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
