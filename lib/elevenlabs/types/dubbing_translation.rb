# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubbingTranslation < ::Elevenlabs::Internal::Types::Model
      field :message_type, -> { ::Elevenlabs::Types::DubbingTranslationMessageType }, optional: false, nullable: false
      field :text, -> { String }, optional: false, nullable: false
      field :segment_id, -> { String }, optional: false, nullable: false
      field :start_s, -> { Float }, optional: false, nullable: false
      field :end_s, -> { Float }, optional: false, nullable: false
      field :speaker_id, -> { String }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(text, 'text', min_length: 1)
        ::Elevenlabs::Validator.validate_string!(segment_id, 'segment_id', min_length: 1)
        Validator.validate_number!(start_s, 'start_s', min: 0)
        Validator.validate_number!(end_s, 'end_s', min: 0)
        ::Elevenlabs::Validator.validate_string!(speaker_id, 'speaker_id', min_length: 1)
      end

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
