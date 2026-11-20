# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionKnowledgeSource < ::Elevenlabs::Internal::Types::Model
      field :source_type, -> { ::Elevenlabs::Types::KnowledgeSourceType }, optional: true, nullable: false
      field :source_url, -> { String }, optional: true, nullable: true
      field :last_scraped_at_unix, -> { Integer }, optional: true, nullable: true
      field :original_filename, -> { String }, optional: true, nullable: false
      field :content_type, -> { String }, optional: true, nullable: false
      field :file_size_bytes, -> { Integer }, optional: true, nullable: false
      field :status, -> { ::Elevenlabs::Types::KnowledgeSourceStatus }, optional: true, nullable: false
      field :error_message, -> { String }, optional: true, nullable: true
      field :failure_reason, -> { ::Elevenlabs::Types::IngestFailure }, optional: true, nullable: true
      field :crawl_entire_site, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :scraped_pages_count, -> { Integer }, optional: true, nullable: false
      field :content_preview, -> { String }, optional: true, nullable: true
      field :processing_started_at_unix, -> { Integer }, optional: true, nullable: true
      field :id, -> { String }, optional: false, nullable: false
      field :created_at_unix, -> { Integer }, optional: true, nullable: false
      field :updated_at_unix, -> { Integer }, optional: true, nullable: false

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
