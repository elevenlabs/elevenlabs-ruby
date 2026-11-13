# frozen_string_literal: true

module Elevenlabs
  module Music
    module Types
      class BodyUploadMusicV1MusicUploadPost < ::Elevenlabs::Internal::Types::Model
        field :file, -> { String }, optional: false, nullable: false
        field :extract_composition_plan, -> { ::Elevenlabs::Music::Types::BodyUploadMusicV1MusicUploadPostExtractCompositionPlan }, optional: true, nullable: false
        field :with_timestamps, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :with_waveform_visual, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
