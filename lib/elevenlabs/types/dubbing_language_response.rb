# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubbingLanguageResponse < ::Elevenlabs::Internal::Types::Model
      field :language_id, -> { String }, optional: false, nullable: false
      field :project_id, -> { String }, optional: false, nullable: false
      field :target_language, -> { String }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::DubbingLanguageResponseStatus }, optional: false, nullable: false
      field :model_id, -> { String }, optional: true, nullable: true
      field :voice_settings, -> { ::Elevenlabs::Types::DubbingLanguageResponseVoiceSettings }, optional: true, nullable: true
      field :outputs, -> { ::Elevenlabs::Types::DubbingLanguageOutputs }, optional: true, nullable: true
      field :revision, -> { Integer }, optional: false, nullable: false
      field :output_revision, -> { Integer }, optional: true, nullable: true
      field :error, -> { ::Elevenlabs::Types::DubbingErrorResponse }, optional: true, nullable: false
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
