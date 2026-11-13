# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentDeploymentPercentageStrategy < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::AgentDeploymentPercentageStrategyType }, optional: true, nullable: false
      field :traffic_percentage, -> { Float }, optional: false, nullable: false

      def validate!
        Validator.validate_number!(traffic_percentage, 'traffic_percentage', min: 0, max: 100)
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
