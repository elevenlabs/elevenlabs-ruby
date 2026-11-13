# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module Members
      module Types
        class UpdateMemberRequest < ::Elevenlabs::Internal::Types::Model
          field :email, -> { String }, optional: false, nullable: false
          field :is_locked, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
          field :workspace_role, -> { ::Elevenlabs::Types::SeatType }, optional: true, nullable: false
          field :workspace_seat_type, -> { ::Elevenlabs::Types::SeatType }, optional: true, nullable: false
          field :allow_downgrade_to_basic_seat, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
  end
end
