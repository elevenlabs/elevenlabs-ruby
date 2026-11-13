# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Pvc
      module Samples
        module Types
          class BodyAddSamplesToPvcVoiceV1VoicesPvcVoiceIDSamplesPost < ::Elevenlabs::Internal::Types::Model
            field :files, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
            field :remove_background_noise, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
