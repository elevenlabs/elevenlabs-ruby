# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReadLegalTerms < ::Elevenlabs::Internal::Types::Model
      field :terms, -> { String }, optional: true, nullable: true
      field :start_date, -> { String }, optional: true, nullable: true
      field :end_date, -> { String }, optional: true, nullable: true

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
