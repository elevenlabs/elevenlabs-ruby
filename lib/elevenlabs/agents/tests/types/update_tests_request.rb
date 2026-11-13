# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tests
      module Types
        module UpdateTestsRequest
          extend ::Elevenlabs::Internal::Types::Union

          member -> { ::Elevenlabs::Types::UpdateResponseUnitTestRequest }
          member -> { ::Elevenlabs::Types::UpdateToolCallUnitTestRequest }
          member -> { ::Elevenlabs::Types::UpdateSimulationTestRequest }

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
