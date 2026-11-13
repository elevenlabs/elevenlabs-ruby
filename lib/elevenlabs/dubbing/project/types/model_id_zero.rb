# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Project
      module Types
        module ModelIDZero
          extend ::Elevenlabs::Internal::Types::Enum

          DUBBING_V1 = :dubbing_v1
          DUBBING_V2 = :dubbing_v2

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
