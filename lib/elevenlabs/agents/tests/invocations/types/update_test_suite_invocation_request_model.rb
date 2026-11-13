# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tests
      module Invocations
        module Types
          class UpdateTestSuiteInvocationRequestModel < ::Elevenlabs::Internal::Types::Model
            field :name, -> { String }, optional: false, nullable: true

            def validate!
              ::Elevenlabs::Validator.validate_string!(name, 'name', min_length: 1, max_length: 256)
            end

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
end
