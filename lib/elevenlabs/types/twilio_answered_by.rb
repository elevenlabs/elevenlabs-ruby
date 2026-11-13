# frozen_string_literal: true

module Elevenlabs
  module Types
    module TwilioAnsweredBy
      extend ::Elevenlabs::Internal::Types::Enum

      HUMAN = :human
      FAX = :fax
      UNKNOWN = :unknown
      MACHINE_START = :machine_start
      MACHINE_END_BEEP = :machine_end_beep
      MACHINE_END_SILENCE = :machine_end_silence
      MACHINE_END_OTHER = :machine_end_other

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
