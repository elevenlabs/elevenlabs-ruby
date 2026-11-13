# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationHistoryTranscriptToolCallWebhookDetails < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::ConversationHistoryTranscriptToolCallWebhookDetailsType }, optional: true, nullable: false
      field :method_, -> { String }, optional: false, nullable: false, api_name: 'method'
      field :url, -> { String }, optional: false, nullable: false
      field :headers, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :path_params, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :query_params, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :body, -> { String }, optional: true, nullable: true

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
