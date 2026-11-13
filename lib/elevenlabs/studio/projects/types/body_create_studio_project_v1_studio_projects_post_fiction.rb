# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Projects
      module Types
        module BodyCreateStudioProjectV1StudioProjectsPostFiction
          extend ::Elevenlabs::Internal::Types::Enum

          FICTION = :fiction
          NON_FICTION = :'non-fiction'

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
