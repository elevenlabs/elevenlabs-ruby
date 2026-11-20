# frozen_string_literal: true

module Elevenlabs
  module ContentProvenance
    module Types
      class BodyCheckWatermarkV1ContentProvenanceWatermarkPost < ::Elevenlabs::Internal::Types::Model
        field :file, -> { String }, optional: false, nullable: false
        field :version, -> { String }, optional: true, nullable: true

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
