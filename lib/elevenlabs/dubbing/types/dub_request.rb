# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Types
      class DubRequest < ::Elevenlabs::Internal::Types::Model
        field :file, -> { String }, optional: true, nullable: true
        field :csv_file, -> { String }, optional: true, nullable: true
        field :foreground_audio_file, -> { String }, optional: true, nullable: true
        field :background_audio_file, -> { String }, optional: true, nullable: true
        field :name, -> { String }, optional: true, nullable: true
        field :source_url, -> { String }, optional: true, nullable: true
        field :source_lang, -> { String }, optional: true, nullable: false
        field :target_lang, -> { String }, optional: false, nullable: true
        field :target_accent, -> { String }, optional: true, nullable: true
        field :num_speakers, -> { Integer }, optional: true, nullable: false
        field :watermark, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :start_time, -> { Integer }, optional: true, nullable: true
        field :end_time, -> { Integer }, optional: true, nullable: true
        field :highest_resolution, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :drop_background_audio, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :use_profanity_filter, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
        field :dubbing_studio, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :disable_voice_cloning, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :mode, -> { ::Elevenlabs::Dubbing::Types::DubRequestMode }, optional: true, nullable: false
        field :csv_fps, -> { Float }, optional: true, nullable: true

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
