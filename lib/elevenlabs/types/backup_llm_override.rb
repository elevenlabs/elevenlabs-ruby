# frozen_string_literal: true

module Elevenlabs
  module Types
    class BackupLlmOverride < ::Elevenlabs::Internal::Types::Model
      field :preference, -> { ::Elevenlabs::Types::BackupLlmOverridePreference }, optional: true, nullable: false
      field :order, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::Llm] }, optional: false, nullable: false

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
