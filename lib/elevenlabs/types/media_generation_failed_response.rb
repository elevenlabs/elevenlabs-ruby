# frozen_string_literal: true

module Elevenlabs
  module Types
    class MediaGenerationFailedResponse < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::MediaGenerationFailedResponseStatus }, optional: false, nullable: false
      field :failure_reason, -> { ::Elevenlabs::Types::MediaGenerationFailedResponseFailureReason }, optional: false, nullable: false
      field :error_message, -> { String }, optional: false, nullable: false

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
