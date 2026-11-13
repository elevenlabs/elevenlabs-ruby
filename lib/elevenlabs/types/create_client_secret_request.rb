# frozen_string_literal: true

module Elevenlabs
  module Types
    class CreateClientSecretRequest < ::Elevenlabs::Internal::Types::Model
      field :session, -> { ::Elevenlabs::Types::OpenAiSessionConfigInput }, optional: true, nullable: true
      field :expires_after, -> { ::Elevenlabs::Types::ExpiresAfter }, optional: true, nullable: true

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
