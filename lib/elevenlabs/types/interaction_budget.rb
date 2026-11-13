# frozen_string_literal: true

module Elevenlabs
  module Types
    module InteractionBudget
      extend ::Elevenlabs::Internal::Types::Enum

      REALTIME = :realtime
      V5_MINUTES = :'5_minutes'
      V10_MINUTES = :'10_minutes'
      V1_HOUR = :'1_hour'

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
