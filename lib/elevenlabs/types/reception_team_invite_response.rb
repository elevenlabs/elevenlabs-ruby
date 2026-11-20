# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionTeamInviteResponse < ::Elevenlabs::Internal::Types::Model
      field :email, -> { String }, optional: false, nullable: false
      field :seat_type, -> { ::Elevenlabs::Types::SeatType }, optional: false, nullable: false
      field :inviting_user_email, -> { String }, optional: true, nullable: true
      field :created_at_unix, -> { Integer }, optional: true, nullable: true

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
