# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubbingRegenerateResponse < ::Elevenlabs::Internal::Types::Model
      field :regenerated_segment_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :regenerated_seconds, -> { Float }, optional: false, nullable: false
      field :charged_seconds, -> { Float }, optional: false, nullable: false
      field :free_regeneration_seconds_remaining, -> { Float }, optional: false, nullable: false

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
