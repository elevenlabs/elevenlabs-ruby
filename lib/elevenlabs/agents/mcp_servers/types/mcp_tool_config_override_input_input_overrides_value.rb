# frozen_string_literal: true

module Elevenlabs
  module Agents
    module McpServers
      module Types
        module McpToolConfigOverrideInputInputOverridesValue
          extend ::Elevenlabs::Internal::Types::Union

          discriminant :source
          member -> { ::Elevenlabs::Types::ConstantSchemaOverride }, key: 'constant'
          member -> { ::Elevenlabs::Types::DynamicVariableSchemaOverride }, key: 'dynamic_variable'
          member -> { ::Elevenlabs::Types::LlmSchemaOverride }, key: 'llm'
          member -> { ::Elevenlabs::Types::OmitSchemaOverride }, key: 'omit'

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
end
