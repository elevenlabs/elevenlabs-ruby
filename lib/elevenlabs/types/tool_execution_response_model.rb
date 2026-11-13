# frozen_string_literal: true

module Elevenlabs
  module Types
    class ToolExecutionResponseModel < ::Elevenlabs::Internal::Types::Model
      field :tool_id, -> { String }, optional: false, nullable: false
      field :tool_request_id, -> { String }, optional: false, nullable: false
      field :conversation_id, -> { String }, optional: false, nullable: false
      field :agent_id, -> { String }, optional: false, nullable: false
      field :branch_id, -> { String }, optional: true, nullable: true
      field :timestamp, -> { Float }, optional: false, nullable: false
      field :latency_secs, -> { Float }, optional: false, nullable: false
      field :is_error, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :request_payload, -> { String }, optional: true, nullable: true
      field :response_payload, -> { String }, optional: true, nullable: true
      field :error_message, -> { String }, optional: true, nullable: true
      field :error_type, -> { String }, optional: true, nullable: true
      field :id, -> { String }, optional: false, nullable: false
      field :tool_call_details, -> { ::Elevenlabs::Types::ToolExecutionResponseModelToolCallDetails }, optional: true, nullable: true

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
