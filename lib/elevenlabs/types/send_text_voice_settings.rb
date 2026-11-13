# frozen_string_literal: true

module Elevenlabs
  module Types
    class SendTextVoiceSettings < ::Elevenlabs::Internal::Types::Model
      field :stability, -> { Float }, optional: true, nullable: false
      field :similarity_boost, -> { Float }, optional: true, nullable: false
      field :style, -> { Float }, optional: true, nullable: false
      field :use_speaker_boost, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :speed, -> { Float }, optional: true, nullable: false

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
