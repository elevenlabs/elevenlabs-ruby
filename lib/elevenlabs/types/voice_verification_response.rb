# frozen_string_literal: true

module Elevenlabs
  module Types
    class VoiceVerificationResponse < ::Elevenlabs::Internal::Types::Model
      field :requires_verification, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :is_verified, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :verification_failures, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :verification_attempts_count, -> { Integer }, optional: false, nullable: false
      field :language, -> { String }, optional: true, nullable: true
      field :verification_attempts, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::VerificationAttemptResponse] }, optional: true, nullable: true

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
