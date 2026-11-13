# frozen_string_literal: true

module Elevenlabs
  module AudioIsolation
    module Types
      class AudioIsolationRequest < ::Elevenlabs::Internal::Types::Model
        field :audio, -> { String }, optional: false, nullable: false
        field :file_format, -> { ::Elevenlabs::AudioIsolation::Types::AudioIsolationRequestFileFormat }, optional: true, nullable: true
        field :preview_b64, -> { String }, optional: true, nullable: true

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
