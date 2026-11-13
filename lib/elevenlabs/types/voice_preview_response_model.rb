# frozen_string_literal: true

module Elevenlabs
  module Types
    class VoicePreviewResponseModel < ::Elevenlabs::Internal::Types::Model
      field :audio_base64, -> { String }, optional: false, nullable: false, api_name: 'audio_base_64'
      field :generated_voice_id, -> { String }, optional: false, nullable: false
      field :media_type, -> { String }, optional: false, nullable: false
      field :duration_secs, -> { Float }, optional: false, nullable: false
      field :language, -> { String }, optional: false, nullable: true

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
