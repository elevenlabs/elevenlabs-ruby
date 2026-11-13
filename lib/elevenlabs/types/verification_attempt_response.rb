# frozen_string_literal: true

module Elevenlabs
  module Types
    class VerificationAttemptResponse < ::Elevenlabs::Internal::Types::Model
      field :text, -> { String }, optional: false, nullable: false
      field :date_unix, -> { Integer }, optional: false, nullable: false
      field :accepted, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :similarity, -> { Float }, optional: false, nullable: false
      field :levenshtein_distance, -> { Float }, optional: false, nullable: false
      field :recording, -> { ::Elevenlabs::Types::RecordingResponse }, optional: true, nullable: true

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
