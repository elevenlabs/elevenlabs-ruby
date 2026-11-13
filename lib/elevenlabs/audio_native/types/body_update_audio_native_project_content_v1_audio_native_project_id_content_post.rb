# frozen_string_literal: true

module Elevenlabs
  module AudioNative
    module Types
      class BodyUpdateAudioNativeProjectContentV1AudioNativeProjectIDContentPost < ::Elevenlabs::Internal::Types::Model
        field :file, -> { String }, optional: true, nullable: false
        field :auto_convert, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :auto_publish, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
