# frozen_string_literal: true

module Elevenlabs
  module Types
    class FollowUpRequestCounts < ::Elevenlabs::Internal::Types::Model
      field :requested, -> { Integer }, optional: false, nullable: false
      field :requested_by_disposition, -> { ::Elevenlabs::Internal::Types::Hash[String, Integer] }, optional: false, nullable: false
      field :distinct_leads, -> { Integer }, optional: false, nullable: false

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
