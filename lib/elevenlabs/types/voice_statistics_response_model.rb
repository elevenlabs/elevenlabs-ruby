# frozen_string_literal: true

module Elevenlabs
  module Types
    class VoiceStatisticsResponseModel < ::Elevenlabs::Internal::Types::Model
      field :project_voice_ref_id, -> { String }, optional: false, nullable: false
      field :characters_unconverted, -> { Integer }, optional: false, nullable: false
      field :characters_converted, -> { Integer }, optional: false, nullable: false
      field :credits_needed_to_convert, -> { Integer }, optional: true, nullable: true
      field :voice_id, -> { String }, optional: true, nullable: false

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
