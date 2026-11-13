# frozen_string_literal: true

module Elevenlabs
  module EnvironmentVariables
    module Types
      module CreateEnvironmentVariablesRequest
        extend ::Elevenlabs::Internal::Types::Union

        discriminant :type
        member -> { ::Elevenlabs::Types::CreateStringEnvironmentVariableRequest }, key: 'string'
        member -> { ::Elevenlabs::Types::CreateSecretEnvironmentVariableRequest }, key: 'secret'
        member -> { ::Elevenlabs::Types::CreateAuthConnectionEnvironmentVariableRequest }, key: 'auth_connection'

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
end
