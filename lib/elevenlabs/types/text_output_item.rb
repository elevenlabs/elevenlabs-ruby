# frozen_string_literal: true

module Elevenlabs
  module Types
    class TextOutputItem < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::TextOutputItemType }, optional: true, nullable: false
      field :role, -> { ::Elevenlabs::Types::TextOutputItemRole }, optional: false, nullable: false
      field :id, -> { String }, optional: true, nullable: true
      field :text, -> { String }, optional: false, nullable: false
      field :created_at_unix_ms, -> { Integer }, optional: true, nullable: true

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
