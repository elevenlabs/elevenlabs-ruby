# frozen_string_literal: true

module Elevenlabs
  module Types
    class ListResponseMeta < ::Elevenlabs::Internal::Types::Model
      field :total, -> { Integer }, optional: true, nullable: true
      field :page, -> { Integer }, optional: true, nullable: true
      field :page_size, -> { Integer }, optional: true, nullable: true

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
