# frozen_string_literal: true

module Elevenlabs
  module Types
    class SubtitlingCommittedSubtitle < ::Elevenlabs::Internal::Types::Model
      field :message_type, -> { ::Elevenlabs::Types::SubtitlingCommittedSubtitleMessageType }, optional: false, nullable: false
      field :cue_index, -> { Integer }, optional: false, nullable: false
      field :lines, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :start_ms, -> { Integer }, optional: false, nullable: false
      field :end_ms, -> { Integer }, optional: false, nullable: false

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
