# frozen_string_literal: true

module Elevenlabs
  module Types
    module ProjectCreationMetaType
      extend ::Elevenlabs::Internal::Types::Enum

      BLANK = :blank
      GENERATE_PODCAST = :generate_podcast
      AUTO_ASSIGN_VOICES = :auto_assign_voices
      DUB_VIDEO = :dub_video
      IMPORT_SPEECH = :import_speech

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
