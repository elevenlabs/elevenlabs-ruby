# frozen_string_literal: true

module Elevenlabs
  module EnvironmentVariables
    module Types
      class UpdateEnvironmentVariableRequest < ::Elevenlabs::Internal::Types::Model
        field :values, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::EnvironmentVariables::Types::UpdateEnvironmentVariableRequestValuesValue] }, optional: false, nullable: false

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
