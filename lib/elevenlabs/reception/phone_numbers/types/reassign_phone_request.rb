# frozen_string_literal: true

module Elevenlabs
  module Reception
    module PhoneNumbers
      module Types
        class ReassignPhoneRequest < ::Elevenlabs::Internal::Types::Model
          field :phone_assignment_id, -> { String }, optional: false, nullable: false
          field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
          field :customer_facing_agent_id, -> { String }, optional: false, nullable: false

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
