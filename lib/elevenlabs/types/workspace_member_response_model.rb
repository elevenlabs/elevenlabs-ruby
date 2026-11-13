# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkspaceMemberResponseModel < ::Elevenlabs::Internal::Types::Model
      field :user_id, -> { String }, optional: false, nullable: false
      field :email, -> { String }, optional: false, nullable: false
      field :first_name, -> { String }, optional: false, nullable: true
      field :seat_type, -> { ::Elevenlabs::Types::SeatType }, optional: false, nullable: false
      field :is_owner, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :is_locked, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
