# frozen_string_literal: true

module Elevenlabs
  module Types
    class BackgroundSoundConfigWorkflowOverride < ::Elevenlabs::Internal::Types::Model
      field :source_type, -> { ::Elevenlabs::Types::BackgroundSoundSourceType }, optional: true, nullable: false
      field :source_id, -> { ::Elevenlabs::Types::BackgroundSoundPresetID }, optional: true, nullable: false
      field :volume, -> { Float }, optional: true, nullable: true
      field :crossfade_loop, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

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
