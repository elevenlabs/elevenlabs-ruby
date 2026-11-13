# frozen_string_literal: true

module Elevenlabs
  module AudioNative
    module Types
      class BodyUpdateAudioNativeContentFromURLV1AudioNativeContentPost < ::Elevenlabs::Internal::Types::Model
        field :url, -> { String }, optional: false, nullable: false
        field :author, -> { String }, optional: true, nullable: true
        field :title, -> { String }, optional: true, nullable: true

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
