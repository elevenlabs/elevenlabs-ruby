# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module CrawlJobs
        module Types
          class GetCrawlJobsRequest < ::Elevenlabs::Internal::Types::Model
            field :crawl_job_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
