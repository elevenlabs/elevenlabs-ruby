# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetAudioNativeProjectSettingsResponseModel < ::Elevenlabs::Internal::Types::Model
      field :enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :snapshot_id, -> { String }, optional: true, nullable: true
      field :settings, -> { ::Elevenlabs::Types::AudioNativeProjectSettingsResponseModel }, optional: true, nullable: true

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
