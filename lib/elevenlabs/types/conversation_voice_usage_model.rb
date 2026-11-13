# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationVoiceUsageModel < ::Elevenlabs::Internal::Types::Model
      field :voice_id, -> { String }, optional: false, nullable: false
      field :audio_output_seconds, -> { Float }, optional: true, nullable: false

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
