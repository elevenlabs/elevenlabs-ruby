# frozen_string_literal: true

module Elevenlabs
  module Types
    class SuppressLeadResponse < ::Elevenlabs::Internal::Types::Model
      field :campaign_id, -> { String }, optional: false, nullable: false
      field :lead_id, -> { String }, optional: false, nullable: false
      field :has_calls_in_flight, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
