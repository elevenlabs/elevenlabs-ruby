# frozen_string_literal: true

module Elevenlabs
  module Types
    class ContextUsageContextUsageEvent < ::Elevenlabs::Internal::Types::Model
      field :event_id, -> { Integer }, optional: false, nullable: false
      field :model, -> { String }, optional: false, nullable: false
      field :context_tokens, -> { Integer }, optional: false, nullable: false
      field :context_limit_tokens, -> { Integer }, optional: false, nullable: false

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
