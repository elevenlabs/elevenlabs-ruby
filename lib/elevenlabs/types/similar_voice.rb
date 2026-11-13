# frozen_string_literal: true

module Elevenlabs
  module Types
    class SimilarVoice < ::Elevenlabs::Internal::Types::Model
      field :voice_id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :category, -> { ::Elevenlabs::Types::SimilarVoiceCategory }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: true
      field :preview_url, -> { String }, optional: true, nullable: true

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
