# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetSecretDependenciesResponseModel < ::Elevenlabs::Internal::Types::Model
      field :dependencies, -> { ::Elevenlabs::Types::GetSecretDependenciesResponseModelDependencies }, optional: false, nullable: false
      field :next_cursor, -> { String }, optional: true, nullable: true

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
