# frozen_string_literal: true

module Elevenlabs
  module Types
    module UpdateOAuth2JwtRequestAlgorithm
      extend ::Elevenlabs::Internal::Types::Enum

      HS256 = :HS256
      HS384 = :HS384
      HS512 = :HS512
      RS256 = :RS256
      RS384 = :RS384
      RS512 = :RS512
      PS256 = :PS256
      PS384 = :PS384
      PS512 = :PS512

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
