# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module CrawlJobs
        module Types
          class BodyCreateCrawlJobV1ConvaiKnowledgeBaseCrawlPost < ::Elevenlabs::Internal::Types::Model
            field :url, -> { String }, optional: false, nullable: false
            field :max_depth, -> { Integer }, optional: true, nullable: false
            field :max_pages, -> { Integer }, optional: true, nullable: false
            field :pattern, -> { String }, optional: true, nullable: true
            field :exclude_patterns, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
            field :sitemap_urls, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
            field :parent_folder_id, -> { String }, optional: true, nullable: true
            field :enable_auto_sync, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
            field :auto_remove, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
            field :auto_discover, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
            field :minimum_frequency_days, -> { Integer }, optional: true, nullable: true

            def validate!
              ::Elevenlabs::Validator.validate_integer!(max_pages, 'max_pages', min: 1, max: 10_000)
              ::Elevenlabs::Validator.validate_string!(pattern, 'pattern', max_length: 2048)
              ::Elevenlabs::Validator.validate_array!(exclude_patterns, 'exclude_patterns', max_items: 50)
              ::Elevenlabs::Validator.validate_array!(sitemap_urls, 'sitemap_urls', max_items: 10_000)
              ::Elevenlabs::Validator.validate_integer!(minimum_frequency_days, 'minimum_frequency_days', min: 1, max: 180)
            end

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
    end
  end
end
