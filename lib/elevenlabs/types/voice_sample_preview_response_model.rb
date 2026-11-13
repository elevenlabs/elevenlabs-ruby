# frozen_string_literal: true

module Elevenlabs
  module Types
    class VoiceSamplePreviewResponseModel < ::Elevenlabs::Internal::Types::Model
      field :audio_base64, -> { String }, optional: false, nullable: false, api_name: 'audio_base_64'
      field :voice_id, -> { String }, optional: false, nullable: false
      field :sample_id, -> { String }, optional: false, nullable: false
      field :media_type, -> { String }, optional: false, nullable: false
      field :duration_secs, -> { Float }, optional: true, nullable: true

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
