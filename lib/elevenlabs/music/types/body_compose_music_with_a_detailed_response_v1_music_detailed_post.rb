# frozen_string_literal: true

module Elevenlabs
  module Music
    module Types
      class BodyComposeMusicWithADetailedResponseV1MusicDetailedPost < ::Elevenlabs::Internal::Types::Model
        field :prompt, -> { String }, optional: true, nullable: true
        field :composition_plan, -> { ::Elevenlabs::Music::Types::BodyComposeMusicWithADetailedResponseV1MusicDetailedPostCompositionPlan }, optional: true, nullable: true
        field :music_length_ms, -> { Integer }, optional: true, nullable: true
        field :model_id, -> { ::Elevenlabs::Types::MusicModelID }, optional: true, nullable: false
        field :seed, -> { Integer }, optional: true, nullable: true
        field :force_instrumental, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :finetune_id, -> { String }, optional: true, nullable: true
        field :respect_sections_durations, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :store_for_inpainting, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :with_timestamps, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :with_waveform_visual, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :sign_with_c2pa, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

        def validate!
          ::Elevenlabs::Validator.validate_string!(prompt, 'prompt', max_length: 4100)
          ::Elevenlabs::Validator.validate_integer!(music_length_ms, 'music_length_ms', min: 3000, max: 600_000)
          ::Elevenlabs::Validator.validate_integer!(seed, 'seed', min: 0, max: 2_147_483_647)
          ::Elevenlabs::Validator.validate_string!(finetune_id, 'finetune_id', max_length: 100)
        end

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
