# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubbingProjectResponse < ::Elevenlabs::Internal::Types::Model
      field :project_id, -> { String }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::DubbingProjectResponseStatus }, optional: false, nullable: false
      field :reference, -> { String }, optional: true, nullable: true
      field :source_language, -> { String }, optional: true, nullable: true
      field :model_id, -> { String }, optional: true, nullable: true
      field :media, -> { ::Elevenlabs::Types::DubbingSourceMediaInfo }, optional: true, nullable: true
      field :language_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :webhook_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :revision, -> { Integer }, optional: false, nullable: false
      field :error, -> { ::Elevenlabs::Types::DubbingErrorResponse }, optional: true, nullable: true
      field :warnings, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::VoicesNotPermittedWarning] }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false

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
