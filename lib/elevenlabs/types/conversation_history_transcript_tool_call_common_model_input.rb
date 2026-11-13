# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationHistoryTranscriptToolCallCommonModelInput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::ToolType }, optional: true, nullable: true
      field :request_id, -> { String }, optional: false, nullable: false
      field :tool_name, -> { String }, optional: false, nullable: false
      field :tool_id, -> { String }, optional: true, nullable: true
      field :params_as_json, -> { String }, optional: false, nullable: false
      field :tool_has_been_called, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :tool_details, -> { ::Elevenlabs::Types::ConversationHistoryTranscriptToolCallCommonModelInputToolDetails }, optional: true, nullable: true

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
