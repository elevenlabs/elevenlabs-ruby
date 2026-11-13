# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetCrawlJobResponseModel < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::CrawlType }, optional: true, nullable: false
      field :seed_url, -> { String }, optional: false, nullable: false
      field :pattern, -> { String }, optional: true, nullable: true
      field :exclude_patterns, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :max_pages, -> { Integer }, optional: false, nullable: false
      field :auto_discover, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :status, -> { ::Elevenlabs::Types::CrawlStatus }, optional: true, nullable: false
      field :pages_identified, -> { Integer }, optional: true, nullable: false
      field :pages_scraped, -> { Integer }, optional: true, nullable: false
      field :pages_skipped, -> { Integer }, optional: true, nullable: false
      field :pages_failed, -> { Integer }, optional: true, nullable: false
      field :root_folder_id, -> { String }, optional: false, nullable: false
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
