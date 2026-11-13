# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentDeploymentResponse < ::Elevenlabs::Internal::Types::Model
      field :traffic_percentage_branch_id_map, -> { ::Elevenlabs::Internal::Types::Hash[String, Float] }, optional: true, nullable: false

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
