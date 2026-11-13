# frozen_string_literal: true

module Elevenlabs
  module Types
    module ListCalendarEventsParamsSmbToolType
      extend ::Elevenlabs::Internal::Types::Enum

      LIST_CALENDAR_EVENTS = :list_calendar_events

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
