# frozen_string_literal: true

module Elevenlabs
  module Types
    class CreateCrawlJobResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :type, -> { ::Elevenlabs::Types::CrawlType }, optional: false, nullable: false
      field :root_folder_id, -> { String }, optional: false, nullable: false
      field :status, -> { String }, optional: false, nullable: false
      field :created_at, -> { Integer }, optional: false, nullable: false
      field :folder_path, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::KnowledgeBaseFolderPathSegmentSummaryResponseModel] }, optional: true, nullable: false

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
