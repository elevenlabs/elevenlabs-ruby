# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentQueueingConfig < ::Elevenlabs::Internal::Types::Model
      field :enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :wait_timeout_seconds, -> { Integer }, optional: true, nullable: false
      field :hold_audio, -> { ::Elevenlabs::Types::AgentHoldAudioConfig }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_integer!(wait_timeout_seconds, 'wait_timeout_seconds', max: 1800)
      end

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
