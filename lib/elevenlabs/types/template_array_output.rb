# frozen_string_literal: true

module Elevenlabs
  module Types
    class TemplateArrayOutput < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::TemplateRunStatus }, optional: false, nullable: false
      field :failure_reason, -> { ::Elevenlabs::Types::TemplateArrayOutputFailureReason }, optional: true, nullable: true
      field :error_message, -> { String }, optional: true, nullable: true
      field :type, -> { ::Elevenlabs::Types::TemplateArrayOutputType }, optional: false, nullable: false
      field :content, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TemplateOutput] }, optional: true, nullable: true
      field :next_cursor, -> { String }, optional: true, nullable: true
      field :has_more, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
