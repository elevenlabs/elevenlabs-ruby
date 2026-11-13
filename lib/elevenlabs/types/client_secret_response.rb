# frozen_string_literal: true

module Elevenlabs
  module Types
    class ClientSecretResponse < ::Elevenlabs::Internal::Types::Model
      field :value, -> { String }, optional: false, nullable: false
      field :expires_at, -> { Integer }, optional: false, nullable: false
      field :session, -> { ::Elevenlabs::Types::OpenAiSessionConfigOutput }, optional: true, nullable: true

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
