# frozen_string_literal: true

module Elevenlabs
  module Types
    class TicketSLAPolicyTargetOutput < ::Elevenlabs::Internal::Types::Model
      field :metric, -> { ::Elevenlabs::Types::SLAMetric }, optional: false, nullable: false
      field :priority, -> { ::Elevenlabs::Types::TicketPriority }, optional: false, nullable: true
      field :duration_secs, -> { Integer }, optional: false, nullable: false

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
