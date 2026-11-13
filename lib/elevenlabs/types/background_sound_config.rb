# frozen_string_literal: true

module Elevenlabs
  module Types
    class BackgroundSoundConfig < ::Elevenlabs::Internal::Types::Model
      field :source_type, -> { ::Elevenlabs::Types::BackgroundSoundSourceType }, optional: true, nullable: true
      field :source_id, -> { ::Elevenlabs::Types::BackgroundSoundPresetID }, optional: true, nullable: true
      field :volume, -> { Float }, optional: true, nullable: false
      field :crossfade_loop, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

      def validate!
        Validator.validate_number!(volume, 'volume', min: 0.01, max: 1)
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
