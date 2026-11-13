# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module AuthConnections
      module Types
        module UpdateAuthConnectionsRequest
          extend ::Elevenlabs::Internal::Types::Union

          member -> { ::Elevenlabs::Types::UpdateOAuth2ClientCredsRequest }
          member -> { ::Elevenlabs::Types::UpdateBasicAuthRequest }
          member -> { ::Elevenlabs::Types::UpdateBearerAuthRequest }
          member -> { ::Elevenlabs::Types::UpdateOAuth2JwtRequest }

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
