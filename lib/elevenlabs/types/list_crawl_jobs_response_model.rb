# frozen_string_literal: true

module Elevenlabs
  module Types
    class ListCrawlJobsResponseModel < ::Elevenlabs::Internal::Types::Model
      field :crawl_jobs, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::GetCrawlJobResponseModel] }, optional: false, nullable: false
      field :next_cursor, -> { String }, optional: true, nullable: true

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
