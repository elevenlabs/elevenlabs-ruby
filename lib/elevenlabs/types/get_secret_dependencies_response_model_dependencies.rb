# frozen_string_literal: true

module Elevenlabs
  module Types
    module GetSecretDependenciesResponseModelDependencies
      extend ::Elevenlabs::Internal::Types::Union

      member -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DependenciesZeroItem] }
      member -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DependenciesOneItem] }
      member -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DependentPhoneNumberIdentifier] }

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
