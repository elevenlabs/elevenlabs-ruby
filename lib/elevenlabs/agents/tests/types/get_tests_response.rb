# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tests
      module Types
        module GetTestsResponse
          extend ::Elevenlabs::Internal::Types::Union

          discriminant :type
          member -> { ::Elevenlabs::Types::GetResponseUnitTestResponseModel }, key: 'llm'
          member -> { ::Elevenlabs::Types::GetToolCallUnitTestResponseModel }, key: 'tool'
          member -> { ::Elevenlabs::Types::GetSimulationTestResponseModel }, key: 'simulation'

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
