# frozen_string_literal: true

module Elevenlabs
  module Types
    class SCIMGroupResponseModel < ::Elevenlabs::Internal::Types::Model
      field :scim_external_id, -> { String }, optional: false, nullable: true
      field :display_name, -> { String }, optional: false, nullable: false
      field :created_at_unix, -> { Integer }, optional: true, nullable: true
      field :updated_at_unix, -> { Integer }, optional: true, nullable: true
      field :seat_type, -> { ::Elevenlabs::Types::SeatType }, optional: true, nullable: false

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
