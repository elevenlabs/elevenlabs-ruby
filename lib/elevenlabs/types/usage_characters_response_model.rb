# frozen_string_literal: true

module Elevenlabs
  module Types
    class UsageCharactersResponseModel < ::Elevenlabs::Internal::Types::Model
      field :time, -> { ::Elevenlabs::Internal::Types::Array[Integer] }, optional: false, nullable: false
      field :usage, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Internal::Types::Array[Float]] }, optional: false, nullable: false

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
