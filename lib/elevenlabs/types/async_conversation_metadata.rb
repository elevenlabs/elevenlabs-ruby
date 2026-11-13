# frozen_string_literal: true

module Elevenlabs
  module Types
    class AsyncConversationMetadata < ::Elevenlabs::Internal::Types::Model
      field :delivery_status, -> { ::Elevenlabs::Types::AsyncConversationMetadataDeliveryStatus }, optional: false, nullable: false
      field :delivery_timestamp, -> { Integer }, optional: false, nullable: false
      field :delivery_error, -> { String }, optional: true, nullable: true
      field :external_system, -> { String }, optional: false, nullable: false
      field :external_id, -> { String }, optional: false, nullable: false
      field :external_link, -> { String }, optional: true, nullable: true
      field :retry_count, -> { Integer }, optional: true, nullable: false
      field :last_retry_timestamp, -> { Integer }, optional: true, nullable: true
      field :last_processed_external_message_id, -> { String }, optional: true, nullable: true
      field :integration_trigger_id, -> { String }, optional: true, nullable: true
      field :platform_metadata, -> { ::Elevenlabs::Types::AsyncConversationMetadataPlatformMetadata }, optional: true, nullable: true

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
