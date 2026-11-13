# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module AuthConnections
      module Types
        module CreateAuthConnectionsRequest
          extend ::Elevenlabs::Internal::Types::Union

          member -> { ::Elevenlabs::Types::CreateOAuth2ClientCredsRequest }
          member -> { ::Elevenlabs::Types::CreateCustomHeaderAuthRequest }
          member -> { ::Elevenlabs::Types::CreateBasicAuthRequest }
          member -> { ::Elevenlabs::Types::CreateBearerAuthRequest }
          member -> { ::Elevenlabs::Types::CreateOAuth2JwtRequest }
          member -> { ::Elevenlabs::Types::CreatePrivateKeyJwtRequest }
          member -> { ::Elevenlabs::Types::CreateMtlsAuthRequest }

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
