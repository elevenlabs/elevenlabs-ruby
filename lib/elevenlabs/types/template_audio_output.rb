# frozen_string_literal: true

module Elevenlabs
  module Types
    class TemplateAudioOutput < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::TemplateRunStatus }, optional: false, nullable: false
      field :failure_reason, -> { ::Elevenlabs::Types::TemplateAudioOutputFailureReason }, optional: true, nullable: true
      field :error_message, -> { String }, optional: true, nullable: true
      field :content_url, -> { String }, optional: true, nullable: true
      field :content_mime_type, -> { String }, optional: true, nullable: true
      field :type, -> { ::Elevenlabs::Types::TemplateAudioOutputType }, optional: false, nullable: false

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
