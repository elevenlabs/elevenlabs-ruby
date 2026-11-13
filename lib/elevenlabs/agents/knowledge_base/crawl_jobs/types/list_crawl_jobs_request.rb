# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module CrawlJobs
        module Types
          class ListCrawlJobsRequest < ::Elevenlabs::Internal::Types::Model
            field :include_job_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

            field :page_size, -> { Integer }, optional: true, nullable: true

            field :cursor, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
