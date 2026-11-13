# frozen_string_literal: true

module Elevenlabs
  module Music
    module CompositionPlan
      module Types
        class BodyGenerateCompositionPlanV1MusicPlanPost < ::Elevenlabs::Internal::Types::Model
          field :prompt, -> { String }, optional: false, nullable: false
          field :music_length_ms, -> { Integer }, optional: true, nullable: true
          field :source_composition_plan, -> { ::Elevenlabs::Music::CompositionPlan::Types::BodyGenerateCompositionPlanV1MusicPlanPostSourceCompositionPlan }, optional: true, nullable: true
          field :model_id, -> { ::Elevenlabs::Types::MusicModelID }, optional: true, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_string!(prompt, 'prompt', max_length: 4100)
            ::Elevenlabs::Validator.validate_integer!(music_length_ms, 'music_length_ms', min: 3000, max: 600_000)
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
end
