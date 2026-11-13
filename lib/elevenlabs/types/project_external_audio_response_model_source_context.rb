# frozen_string_literal: true

module Elevenlabs
  module Types
    module ProjectExternalAudioResponseModelSourceContext
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :source_type
      member -> { ::Elevenlabs::Types::MusicExploreSongSourceContext }, key: 'music_explore_song'
      member -> { ::Elevenlabs::Types::SfxSourceContext }, key: 'sfx'
      member -> { ::Elevenlabs::Types::SongSourceContext }, key: 'song'

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
