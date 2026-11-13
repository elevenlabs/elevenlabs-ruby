# frozen_string_literal: true

module Elevenlabs
  module Agents
    module McpServers
      module Types
        module McpServerConfigOutputRequestHeadersValue
          extend ::Elevenlabs::Internal::Types::Union

          member -> { String }
          member -> { ::Elevenlabs::Types::ConvAiSecretLocator }
          member -> { ::Elevenlabs::Types::ConvAiDynamicVariable }
          member -> { ::Elevenlabs::Types::ConvAiEnvVarLocator }

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
