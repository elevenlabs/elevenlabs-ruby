# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubbingAudio < ::Elevenlabs::Internal::Types::Model
      field :message_type, -> { ::Elevenlabs::Types::DubbingAudioMessageType }, optional: false, nullable: false
      field :data, -> { String }, optional: false, nullable: false
      field :sample_rate, -> { Integer }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(data, 'data', min_length: 1)
      end

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
