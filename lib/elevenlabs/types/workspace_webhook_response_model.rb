# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkspaceWebhookResponseModel < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :webhook_id, -> { String }, optional: false, nullable: false
      field :webhook_url, -> { String }, optional: false, nullable: false
      field :is_disabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :is_auto_disabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :created_at_unix, -> { Integer }, optional: false, nullable: false
      field :auth_type, -> { ::Elevenlabs::Types::WebhookAuthMethodType }, optional: false, nullable: false
      field :usage, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WorkspaceWebhookUsageResponseModel] }, optional: true, nullable: true
      field :events, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WorkspaceWebhookEventType] }, optional: true, nullable: true
      field :most_recent_failure_error_code, -> { Integer }, optional: true, nullable: true
      field :most_recent_failure_timestamp, -> { Integer }, optional: true, nullable: true

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
