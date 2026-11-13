# frozen_string_literal: true

module Elevenlabs
  module Types
    class FlushContext < ::Elevenlabs::Internal::Types::Model
      field :context_id, -> { String }, optional: false, nullable: false
      field :text, -> { String }, optional: true, nullable: false
      field :flush, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
