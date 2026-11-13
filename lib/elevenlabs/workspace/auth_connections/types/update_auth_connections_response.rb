# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module AuthConnections
      module Types
        module UpdateAuthConnectionsResponse
          extend ::Elevenlabs::Internal::Types::Union

          discriminant :auth_type
          member -> { ::Elevenlabs::Types::OAuth2ClientCredsResponse }, key: 'oauth2_client_credentials'
          member -> { ::Elevenlabs::Types::RefreshTokenAuthResponse }, key: 'refresh_token_auth'
          member -> { ::Elevenlabs::Types::BasicAuthResponse }, key: 'basic_auth'
          member -> { ::Elevenlabs::Types::BearerAuthResponse }, key: 'bearer_auth'
          member -> { ::Elevenlabs::Types::OAuth2JwtResponse }, key: 'oauth2_jwt'
          member -> { ::Elevenlabs::Types::PrivateKeyJwtResponse }, key: 'private_key_jwt'
          member -> { ::Elevenlabs::Types::MtlsAuthResponse }, key: 'mtls'
          member -> { ::Elevenlabs::Types::CustomHeaderAuthResponse }, key: 'custom_header_auth'
          member -> { ::Elevenlabs::Types::APIIntegrationOAuth2AuthCodeResponse }, key: 'api_integration_oauth2_auth_code'
          member -> { ::Elevenlabs::Types::APIIntegrationOAuth2CustomAppResponse }, key: 'api_integration_oauth2_custom_app'
          member -> { ::Elevenlabs::Types::WhatsAppAuthResponse }, key: 'whatsapp_auth'
          member -> { ::Elevenlabs::Types::SlackBotAuthResponse }, key: 'slack_bot_auth'
          member -> { ::Elevenlabs::Types::URLSecretAuthResponse }, key: 'url_secret'

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
