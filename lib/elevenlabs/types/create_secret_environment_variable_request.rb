# frozen_string_literal: true

module Elevenlabs
  module Types
    class CreateSecretEnvironmentVariableRequest < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::CreateSecretEnvironmentVariableRequestType }, optional: false, nullable: false
      field :label, -> { String }, optional: false, nullable: false
      field :values, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::EnvironmentVariableSecretValueRequest] }, optional: false, nullable: false

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
