# frozen_string_literal: true

module Elevenlabs
  module Types
    class TranslateAudio < ::Elevenlabs::Internal::Types::Model
      field :message_type, -> { ::Elevenlabs::Types::TranslateAudioMessageType }, optional: false, nullable: false
      field :data, -> { String }, optional: false, nullable: false
      field :sample_rate, -> { Integer }, optional: false, nullable: false

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
