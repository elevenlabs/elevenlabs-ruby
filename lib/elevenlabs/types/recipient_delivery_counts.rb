# frozen_string_literal: true

module Elevenlabs
  module Types
    class RecipientDeliveryCounts < ::Elevenlabs::Internal::Types::Model
      field :sent, -> { Integer }, optional: true, nullable: false
      field :delivered, -> { Integer }, optional: true, nullable: false
      field :read, -> { Integer }, optional: true, nullable: false
      field :replied, -> { Integer }, optional: true, nullable: false
      field :failed, -> { Integer }, optional: true, nullable: false

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
