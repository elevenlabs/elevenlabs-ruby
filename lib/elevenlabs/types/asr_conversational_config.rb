# frozen_string_literal: true

module Elevenlabs
  module Types
    class AsrConversationalConfig < ::Elevenlabs::Internal::Types::Model
      field :quality, -> { ::Elevenlabs::Types::AsrQuality }, optional: true, nullable: false
      field :provider, -> { ::Elevenlabs::Types::AsrProvider }, optional: true, nullable: false
      field :user_input_audio_format, -> { ::Elevenlabs::Types::AsrInputFormat }, optional: true, nullable: false
      field :keywords, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false

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
