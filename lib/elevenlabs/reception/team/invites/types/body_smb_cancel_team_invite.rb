# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Team
      module Invites
        module Types
          class BodySmbCancelTeamInvite < ::Elevenlabs::Internal::Types::Model
            field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
            field :email, -> { String }, optional: false, nullable: false

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
