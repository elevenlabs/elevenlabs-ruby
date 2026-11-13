# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConvAiUserSecretDbModel < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :encrypted_value, -> { String }, optional: false, nullable: false
      field :nonce, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false

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
