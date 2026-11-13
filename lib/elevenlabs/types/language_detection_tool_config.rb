# frozen_string_literal: true

module Elevenlabs
  module Types
    class LanguageDetectionToolConfig < ::Elevenlabs::Internal::Types::Model
      field :system_tool_type, -> { ::Elevenlabs::Types::LanguageDetectionToolConfigSystemToolType }, optional: true, nullable: false
      field :only_at_conversation_start, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
