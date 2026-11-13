# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowStandaloneAgentNodeModelInput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::WorkflowStandaloneAgentNodeModelInputType }, optional: true, nullable: false
      field :position, -> { ::Elevenlabs::Types::PositionInput }, optional: true, nullable: false
      field :edge_order, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :agent_id, -> { String }, optional: true, nullable: true
      field :branch_id, -> { String }, optional: true, nullable: true
      field :node_id, -> { String }, optional: true, nullable: true
      field :delay_ms, -> { Integer }, optional: true, nullable: false
      field :transfer_message, -> { String }, optional: true, nullable: true
      field :enable_transferred_agent_first_message, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :preserve_client_tts_overrides, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :preserve_voice_settings, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(node_id, 'node_id', min_length: 1)
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
