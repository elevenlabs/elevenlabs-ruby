# frozen_string_literal: true

module Elevenlabs
  module AudioNative
    module Types
      module BodyCreatesAudioNativeEnabledProjectV1AudioNativePostApplyTextNormalization
        extend ::Elevenlabs::Internal::Types::Enum

        AUTO = :auto
        ON = :on
        OFF = :off
        APPLY_ENGLISH = :apply_english

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
