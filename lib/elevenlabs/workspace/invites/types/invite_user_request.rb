# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module Invites
      module Types
        class InviteUserRequest < ::Elevenlabs::Internal::Types::Model
          field :email, -> { String }, optional: false, nullable: false
          field :workspace_permission, -> { String }, optional: true, nullable: true
          field :seat_type, -> { ::Elevenlabs::Types::SeatType }, optional: true, nullable: false
          field :group_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
          field :usage_limit, -> { Integer }, optional: true, nullable: true

          def validate!
            ::Elevenlabs::Validator.validate_integer!(usage_limit, 'usage_limit', min: 0)
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
  end
end
