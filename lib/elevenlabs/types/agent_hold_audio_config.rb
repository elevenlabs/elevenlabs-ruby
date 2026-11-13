# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentHoldAudioConfig < ::Elevenlabs::Internal::Types::Model
      field :audio_path, -> { String }, optional: false, nullable: false
      field :audio_url, -> { String }, optional: false, nullable: false
      field :original_filename, -> { String }, optional: false, nullable: false
      field :duration_secs, -> { Float }, optional: false, nullable: false
      field :size_bytes, -> { Integer }, optional: false, nullable: false

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
