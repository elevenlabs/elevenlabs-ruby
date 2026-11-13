# frozen_string_literal: true

module Elevenlabs
  module Music
    module Finetunes
      module Types
        module BodyCreateMusicFinetuneV1MusicFinetunesPostVisibility
          extend ::Elevenlabs::Internal::Types::Enum

          PRIVATE = :private
          WORKSPACE = :workspace

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
