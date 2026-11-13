# frozen_string_literal: true

module Elevenlabs
  module Types
    class BodyRenderAudioOrVideoForTheGivenLanguageV1DubbingResourceDubbingIDRenderLanguagePost < ::Elevenlabs::Internal::Types::Model
      field :render_type, -> { ::Elevenlabs::Types::RenderType }, optional: false, nullable: false
      field :normalize_volume, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

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
