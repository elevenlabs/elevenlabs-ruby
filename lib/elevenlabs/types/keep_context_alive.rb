# frozen_string_literal: true

module Elevenlabs
  module Types
    class KeepContextAlive < ::Elevenlabs::Internal::Types::Model
      field :text, -> { ::Elevenlabs::Types::KeepContextAliveText }, optional: false, nullable: false
      field :context_id, -> { String }, optional: false, nullable: false

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
