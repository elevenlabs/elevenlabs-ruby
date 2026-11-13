# frozen_string_literal: true

module Elevenlabs
  module Types
    class BuiltInToolsInput < ::Elevenlabs::Internal::Types::Model
      field :transfer_to_agent, -> { ::Elevenlabs::Types::SystemToolConfigInput }, optional: true, nullable: true
      field :end_call, -> { ::Elevenlabs::Types::SystemToolConfigInput }, optional: true, nullable: false
      field :language_detection, -> { ::Elevenlabs::Types::SystemToolConfigInput }, optional: true, nullable: false
      field :transfer_to_number, -> { ::Elevenlabs::Types::SystemToolConfigInput }, optional: true, nullable: false
      field :skip_turn, -> { ::Elevenlabs::Types::SystemToolConfigInput }, optional: true, nullable: false
      field :play_keypad_touch_tone, -> { ::Elevenlabs::Types::SystemToolConfigInput }, optional: true, nullable: false
      field :voicemail_detection, -> { ::Elevenlabs::Types::SystemToolConfigInput }, optional: true, nullable: false

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
