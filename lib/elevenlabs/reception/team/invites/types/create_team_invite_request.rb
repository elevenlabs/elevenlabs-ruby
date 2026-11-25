# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Team
      module Invites
        module Types
          class CreateTeamInviteRequest < ::Elevenlabs::Internal::Types::Model
            field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
            field :email, -> { String }, optional: false, nullable: false
            field :role, -> { ::Elevenlabs::Reception::Team::Invites::Types::CreateTeamInviteRequestRole }, optional: true, nullable: false

            def validate!
              ::Elevenlabs::Validator.validate_string!(email, 'email', min_length: 1, max_length: 254)
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
end
