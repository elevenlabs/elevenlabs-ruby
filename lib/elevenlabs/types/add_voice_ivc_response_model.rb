# frozen_string_literal: true

module Elevenlabs
  module Types
    class AddVoiceIvcResponseModel < ::Elevenlabs::Internal::Types::Model
      field :voice_id, -> { String }, optional: false, nullable: false
      field :requires_verification, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :library_voice_match, -> { ::Elevenlabs::Types::LibraryVoiceMatchResponseModel }, optional: true, nullable: true

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
