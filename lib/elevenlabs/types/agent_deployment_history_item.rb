# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentDeploymentHistoryItem < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :traffic_percentage_branch_id_map, -> { ::Elevenlabs::Internal::Types::Hash[String, Float] }, optional: true, nullable: false
      field :deployed_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :is_active, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :source, -> { ::Elevenlabs::Types::AgentDeploymentSource }, optional: true, nullable: true
      field :access_info, -> { ::Elevenlabs::Types::ResourceAccessInfo }, optional: true, nullable: false

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
