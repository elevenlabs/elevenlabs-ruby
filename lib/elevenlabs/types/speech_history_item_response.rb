# frozen_string_literal: true

module Elevenlabs
  module Types
    class SpeechHistoryItemResponse < ::Elevenlabs::Internal::Types::Model
      field :history_item_id, -> { String }, optional: false, nullable: false
      field :request_id, -> { String }, optional: true, nullable: true
      field :voice_id, -> { String }, optional: true, nullable: true
      field :model_id, -> { String }, optional: true, nullable: true
      field :voice_name, -> { String }, optional: true, nullable: true
      field :voice_category, -> { ::Elevenlabs::Types::SpeechHistoryItemResponseVoiceCategory }, optional: true, nullable: true
      field :text, -> { String }, optional: true, nullable: true
      field :date_unix, -> { Integer }, optional: false, nullable: false
      field :character_count_change_from, -> { Integer }, optional: false, nullable: false
      field :character_count_change_to, -> { Integer }, optional: false, nullable: false
      field :content_type, -> { String }, optional: false, nullable: false
      field :state, -> { Object }, optional: false, nullable: false
      field :settings, -> { Object }, optional: true, nullable: true
      field :share_link_id, -> { String }, optional: true, nullable: true
      field :source, -> { ::Elevenlabs::Types::SpeechHistoryItemResponseSource }, optional: true, nullable: true
      field :alignments, -> { ::Elevenlabs::Types::HistoryAlignmentsResponseModel }, optional: true, nullable: true
      field :dialogue, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DialogueInputResponseModel] }, optional: true, nullable: true
      field :output_format, -> { String }, optional: true, nullable: true

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
