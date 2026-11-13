# frozen_string_literal: true

module Elevenlabs
  module Types
    class MusicFinetuneResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :tags, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :primary_genre, -> { String }, optional: true, nullable: true
      field :model_id, -> { String }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :visibility, -> { ::Elevenlabs::Types::FinetuneVisibility }, optional: false, nullable: false
      field :created_by, -> { ::Elevenlabs::Types::FinetuneCreatedBy }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::MusicFinetuneStatus }, optional: false, nullable: false
      field :training_progress, -> { Float }, optional: false, nullable: false
      field :failure_reason, -> { ::Elevenlabs::Types::MusicFinetuneFailureReason }, optional: true, nullable: true

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
