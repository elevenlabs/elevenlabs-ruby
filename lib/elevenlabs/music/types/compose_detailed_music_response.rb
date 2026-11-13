# frozen_string_literal: true

module Elevenlabs
  module Music
    module Types
      class ComposeDetailedMusicResponse < ::Elevenlabs::Internal::Types::Model
        field :composition_plan, -> { Object }, optional: true, nullable: false
        field :song_metadata, -> { Object }, optional: true, nullable: false
        field :audio, -> { String }, optional: true, nullable: false

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
