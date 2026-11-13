# frozen_string_literal: true

module Elevenlabs
  module Types
    class TemplateStringOutput < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::TemplateRunStatus }, optional: false, nullable: false
      field :failure_reason, -> { ::Elevenlabs::Types::TemplateStringOutputFailureReason }, optional: true, nullable: true
      field :error_message, -> { String }, optional: true, nullable: true
      field :type, -> { ::Elevenlabs::Types::TemplateStringOutputType }, optional: false, nullable: false
      field :content, -> { String }, optional: true, nullable: true

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
