# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationHistoryTranscriptAPIIntegrationWebhookToolsResultCommonModelInput < ::Elevenlabs::Internal::Types::Model
      field :request_id, -> { String }, optional: false, nullable: false
      field :tool_name, -> { String }, optional: false, nullable: false
      field :tool_id, -> { String }, optional: true, nullable: true
      field :result_value, -> { String }, optional: false, nullable: false
      field :is_error, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :is_blocked, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :tool_has_been_called, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :tool_latency_secs, -> { Float }, optional: true, nullable: false
      field :error_type, -> { String }, optional: true, nullable: false
      field :raw_error_message, -> { String }, optional: true, nullable: false
      field :dynamic_variable_updates, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DynamicVariableUpdateCommonModel] }, optional: true, nullable: false
      field :type, -> { ::Elevenlabs::Types::ConversationHistoryTranscriptAPIIntegrationWebhookToolsResultCommonModelInputType }, optional: false, nullable: false
      field :integration_id, -> { String }, optional: true, nullable: false
      field :credential_id, -> { String }, optional: true, nullable: false
      field :integration_connection_id, -> { String }, optional: true, nullable: false

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
