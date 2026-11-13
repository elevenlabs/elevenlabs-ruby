# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Projects
      module PronunciationDictionaries
        module Types
          module ListPronunciationDictionariesRequestSort
            extend ::Elevenlabs::Internal::Types::Enum

            CREATION_TIME_UNIX = :creation_time_unix
            NAME = :name

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
