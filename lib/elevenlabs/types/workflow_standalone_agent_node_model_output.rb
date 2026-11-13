# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowStandaloneAgentNodeModelOutput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::WorkflowStandaloneAgentNodeModelOutputType }, optional: false, nullable: false
      field :position, -> { ::Elevenlabs::Types::PositionOutput }, optional: false, nullable: false
      field :edge_order, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :agent_id, -> { String }, optional: false, nullable: true
      field :branch_id, -> { String }, optional: false, nullable: true
      field :node_id, -> { String }, optional: false, nullable: true
      field :delay_ms, -> { Integer }, optional: false, nullable: false
      field :transfer_message, -> { String }, optional: false, nullable: true
      field :enable_transferred_agent_first_message, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :preserve_client_tts_overrides, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :preserve_voice_settings, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
