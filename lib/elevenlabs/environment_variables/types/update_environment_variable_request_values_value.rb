# frozen_string_literal: true

module Elevenlabs
  module EnvironmentVariables
    module Types
      module UpdateEnvironmentVariableRequestValuesValue
        extend ::Elevenlabs::Internal::Types::Union

        member -> { String }
        member -> { ::Elevenlabs::Types::EnvironmentVariableSecretValueRequest }
        member -> { ::Elevenlabs::Types::EnvironmentVariableAuthConnectionValueRequest }

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
