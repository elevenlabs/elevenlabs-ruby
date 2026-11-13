# frozen_string_literal: true

module Elevenlabs
  module Types
    class CommittedTranscriptEntitiesEntitiesItem < ::Elevenlabs::Internal::Types::Model
      field :text, -> { String }, optional: false, nullable: false
      field :entity_type, -> { String }, optional: false, nullable: false
      field :start_char, -> { Integer }, optional: false, nullable: false
      field :end_char, -> { Integer }, optional: false, nullable: false

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
