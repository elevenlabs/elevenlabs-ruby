# frozen_string_literal: true

module Elevenlabs
  module Types
    class KbExternalSyncJob < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::ExternalSyncProvider }, optional: false, nullable: false
      field :folder_id, -> { String }, optional: false, nullable: false
      field :integration_connection_id, -> { String }, optional: false, nullable: false
      field :triggered_by, -> { ::Elevenlabs::Types::ExternalSyncJobTrigger }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::CrawlStatus }, optional: true, nullable: false
      field :sync_type, -> { ::Elevenlabs::Types::ExternalSyncJobType }, optional: true, nullable: true
      field :items_identified, -> { Integer }, optional: true, nullable: false
      field :items_processed, -> { Integer }, optional: true, nullable: false
      field :error_message, -> { String }, optional: true, nullable: true
      field :started_at, -> { Integer }, optional: true, nullable: true
      field :completed_at, -> { Integer }, optional: true, nullable: true
      field :updated_at, -> { Integer }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :created_at, -> { Integer }, optional: false, nullable: false

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
