# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Types
      class RunAgentTestsRequestModel < ::Elevenlabs::Internal::Types::Model
        field :name, -> { String }, optional: true, nullable: true
        field :tests, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::SingleTestRunRequestModel] }, optional: false, nullable: false
        field :agent_config_override, -> { ::Elevenlabs::Types::AdhocAgentConfigOverrideForTestRequestModel }, optional: true, nullable: true
        field :branch_id, -> { String }, optional: true, nullable: true
        field :repeat_count, -> { Integer }, optional: true, nullable: false

        def validate!
          ::Elevenlabs::Validator.validate_string!(name, 'name', min_length: 1, max_length: 256)
          ::Elevenlabs::Validator.validate_array!(tests, 'tests', min_items: 1, max_items: 5000)
          ::Elevenlabs::Validator.validate_integer!(repeat_count, 'repeat_count', min: 1, max: 50)
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
