# frozen_string_literal: true

module Elevenlabs
  module Types
    class AudioNativeProjectSettingsResponseModel < ::Elevenlabs::Internal::Types::Model
      field :title, -> { String }, optional: false, nullable: false
      field :image, -> { String }, optional: false, nullable: false
      field :author, -> { String }, optional: false, nullable: false
      field :small, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :text_color, -> { String }, optional: false, nullable: false
      field :background_color, -> { String }, optional: false, nullable: false
      field :sessionization, -> { Integer }, optional: false, nullable: false
      field :audio_path, -> { String }, optional: true, nullable: true
      field :audio_url, -> { String }, optional: true, nullable: true
      field :status, -> { ::Elevenlabs::Types::AudioNativeProjectSettingsResponseModelStatus }, optional: true, nullable: false

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
