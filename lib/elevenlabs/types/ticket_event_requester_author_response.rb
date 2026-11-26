# frozen_string_literal: true

module Elevenlabs
  module Types
    class TicketEventRequesterAuthorResponse < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :first_name, -> { String }, optional: false, nullable: true
      field :last_name, -> { String }, optional: false, nullable: true
      field :full_name, -> { String }, optional: false, nullable: true
      field :email, -> { String }, optional: false, nullable: true
      field :type, -> { ::Elevenlabs::Types::TicketEventRequesterAuthorResponseType }, optional: false, nullable: false

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
