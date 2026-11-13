# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Project
      module Types
        module ListProjectRequestSortDirection
          extend ::Elevenlabs::Internal::Types::Enum

          ASCENDING = :ASCENDING
          DESCENDING = :DESCENDING

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
