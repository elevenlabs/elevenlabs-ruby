# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowFeaturesUsageCommonModel < ::Elevenlabs::Internal::Types::Model
      field :enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :tool_node, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :standalone_agent_node, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :phone_number_node, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :end_node, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false
      field :override_agent_node, -> { ::Elevenlabs::Types::FeatureStatusCommonModel }, optional: true, nullable: false

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
