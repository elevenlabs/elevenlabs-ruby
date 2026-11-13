# frozen_string_literal: true

module Elevenlabs
  module Types
    class OTelStatus < ::Elevenlabs::Internal::Types::Model
      field :code, -> { Integer }, optional: false, nullable: false
      field :message, -> { String }, optional: true, nullable: true

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
