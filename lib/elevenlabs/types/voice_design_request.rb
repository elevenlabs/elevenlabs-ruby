# frozen_string_literal: true

module Elevenlabs
  module Types
    class VoiceDesignRequest < ::Elevenlabs::Internal::Types::Model
      field :voice_description, -> { String }, optional: false, nullable: false
      field :text, -> { String }, optional: true, nullable: true
      field :auto_generate_text, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :loudness, -> { Float }, optional: true, nullable: false
      field :quality, -> { Float }, optional: true, nullable: false
      field :seed, -> { Integer }, optional: true, nullable: true
      field :guidance_scale, -> { Float }, optional: true, nullable: false
      field :should_enhance, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(voice_description, 'voice_description', min_length: 20, max_length: 1000)
        ::Elevenlabs::Validator.validate_string!(text, 'text', min_length: 100, max_length: 1000)
        Validator.validate_number!(loudness, 'loudness', min: -1, max: 1)
        Validator.validate_number!(quality, 'quality', min: -1, max: 1)
        ::Elevenlabs::Validator.validate_integer!(seed, 'seed', min: 0, max: 2_147_483_647)
        Validator.validate_number!(guidance_scale, 'guidance_scale', min: 0, max: 100)
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
