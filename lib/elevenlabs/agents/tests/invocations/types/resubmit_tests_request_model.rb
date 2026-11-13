# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tests
      module Invocations
        module Types
          class ResubmitTestsRequestModel < ::Elevenlabs::Internal::Types::Model
            field :test_run_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
            field :agent_config_override, -> { ::Elevenlabs::Types::AdhocAgentConfigOverrideForTestRequestModel }, optional: true, nullable: false
            field :agent_id, -> { String }, optional: false, nullable: false
            field :branch_id, -> { String }, optional: true, nullable: true

            def validate!
              ::Elevenlabs::Validator.validate_array!(test_run_ids, 'test_run_ids', min_items: 1, max_items: 5000)
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
