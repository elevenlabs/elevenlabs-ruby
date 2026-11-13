# frozen_string_literal: true

module Elevenlabs
  module V1DubbingLive
    module Types
      module DubbingLiveMaxLagS
        extend ::Elevenlabs::Internal::Types::Enum

        V10 = 10
        V12 = 12
        V15 = 15
        V18 = 18
        V20 = 20
        V25 = 25
        V30 = 30

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
end
