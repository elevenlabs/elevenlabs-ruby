# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Pvc
      module Verification
        module Types
          class BodyRequestManualVerificationV1VoicesPvcVoiceIDVerificationPost < ::Elevenlabs::Internal::Types::Model
            field :files, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
            field :extra_text, -> { String }, optional: true, nullable: true

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
  end
end
