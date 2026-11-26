# frozen_string_literal: true

module Elevenlabs
  module Types
    class TicketRequesterByEmailRequest < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::TicketRequesterByEmailRequestType }, optional: true, nullable: false
      field :value, -> { String }, optional: false, nullable: false
      field :full_name, -> { String }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_string!(value, 'value', min_length: 1)
        ::Elevenlabs::Validator.validate_string!(full_name, 'full_name', min_length: 1)
      end

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
