# frozen_string_literal: true

module Elevenlabs
  module Types
    class InternalKbCrawlPageTiming < ::Elevenlabs::Internal::Types::Model
      field :url, -> { String }, optional: false, nullable: false
      field :doc_id, -> { String }, optional: false, nullable: false
      field :read_ms, -> { Integer }, optional: true, nullable: true
      field :index_ms, -> { Integer }, optional: true, nullable: true
      field :html_len, -> { Integer }, optional: true, nullable: true
      field :skipped, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :error, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
