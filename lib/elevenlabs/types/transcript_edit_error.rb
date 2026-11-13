# frozen_string_literal: true

module Elevenlabs
  module Types
    class TranscriptEditError < ::Elevenlabs::Internal::Types::Model
      field :kind, -> { ::Elevenlabs::Types::TranscriptEditErrorKind }, optional: false, nullable: false
      field :error_type, -> { ::Elevenlabs::Types::TranscriptEditErrorErrorType }, optional: false, nullable: false
      field :message, -> { String }, optional: false, nullable: false

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
