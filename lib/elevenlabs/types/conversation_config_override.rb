# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationConfigOverride < ::Elevenlabs::Internal::Types::Model
      field :text_only, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :max_duration_seconds, -> { Integer }, optional: true, nullable: true

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
