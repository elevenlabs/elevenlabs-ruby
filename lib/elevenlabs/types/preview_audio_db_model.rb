# frozen_string_literal: true

module Elevenlabs
  module Types
    class PreviewAudioDbModel < ::Elevenlabs::Internal::Types::Model
      field :voice_id, -> { String }, optional: true, nullable: true
      field :text, -> { String }, optional: true, nullable: true
      field :audio_url, -> { String }, optional: false, nullable: false
      field :hls_manifest_url, -> { String }, optional: true, nullable: true
      field :dash_manifest_url, -> { String }, optional: true, nullable: true
      field :is_auto_generated, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :generated_at_unix, -> { Integer }, optional: true, nullable: true

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
