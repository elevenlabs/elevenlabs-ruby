# frozen_string_literal: true

module Elevenlabs
  module Types
    module PromptAgentAPIModelOutputBackupLlmConfig
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :preference
      member -> { ::Elevenlabs::Types::BackupLlmDefault }, key: 'default'
      member -> { ::Elevenlabs::Types::BackupLlmDisabled }, key: 'disabled'
      member -> { ::Elevenlabs::Types::BackupLlmOverride }, key: 'override'

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
