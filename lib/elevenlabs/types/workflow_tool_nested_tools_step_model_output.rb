# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowToolNestedToolsStepModelOutput < ::Elevenlabs::Internal::Types::Model
      field :step_latency_secs, -> { Float }, optional: false, nullable: false
      field :type, -> { ::Elevenlabs::Types::WorkflowToolNestedToolsStepModelOutputType }, optional: true, nullable: false
      field :node_id, -> { String }, optional: false, nullable: false
      field :requests, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationHistoryTranscriptToolCallCommonModelOutput] }, optional: false, nullable: false
      field :results, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WorkflowToolNestedToolsStepModelOutputResultsItem] }, optional: false, nullable: false
      field :is_successful, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
