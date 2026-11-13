# frozen_string_literal: true

module Elevenlabs
  module Types
    class FileRefreshStatus < ::Elevenlabs::Internal::Types::Model
      field :status, -> { ::Elevenlabs::Types::CrawlStatus }, optional: true, nullable: false
      field :enqueued_at, -> { Integer }, optional: true, nullable: true
      field :started_at, -> { Integer }, optional: true, nullable: true
      field :completed_at, -> { Integer }, optional: true, nullable: true
      field :last_synced_at, -> { Integer }, optional: true, nullable: true
      field :error_message, -> { String }, optional: true, nullable: true

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
