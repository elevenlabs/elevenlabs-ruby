# frozen_string_literal: true

module Elevenlabs
  module ServiceAccounts
    module APIKeys
      module Types
        class BodyEditServiceAccountApiKeyV1ServiceAccountsServiceAccountUserIdApiKeysApiKeyIdPatch < ::Elevenlabs::Internal::Types::Model
          field :is_enabled, -> { ::Elevenlabs::ServiceAccounts::APIKeys::Types::BodyEditServiceAccountApiKeyV1ServiceAccountsServiceAccountUserIdApiKeysApiKeyIdPatchIsEnabled }, optional: true, nullable: false
          field :name, -> { String }, optional: true, nullable: true
          field :permissions, -> { ::Elevenlabs::ServiceAccounts::APIKeys::Types::BodyEditServiceAccountApiKeyV1ServiceAccountsServiceAccountUserIdApiKeysApiKeyIdPatchPermissions }, optional: true, nullable: false
          field :character_limit, -> { ::Elevenlabs::ServiceAccounts::APIKeys::Types::BodyEditServiceAccountApiKeyV1ServiceAccountsServiceAccountUserIdApiKeysApiKeyIdPatchCharacterLimit }, optional: true, nullable: true
          field :allowed_ips, -> { ::Elevenlabs::ServiceAccounts::APIKeys::Types::BodyEditServiceAccountApiKeyV1ServiceAccountsServiceAccountUserIdApiKeysApiKeyIdPatchAllowedIps }, optional: true, nullable: false
          field :third_party_disable_allowed, -> { ::Elevenlabs::ServiceAccounts::APIKeys::Types::BodyEditServiceAccountApiKeyV1ServiceAccountsServiceAccountUserIdApiKeysApiKeyIdPatchThirdPartyDisableAllowed }, optional: true, nullable: false
          field :tts_concurrency_limit, -> { ::Elevenlabs::ServiceAccounts::APIKeys::Types::BodyEditServiceAccountApiKeyV1ServiceAccountsServiceAccountUserIdApiKeysApiKeyIdPatchTtsConcurrencyLimit }, optional: true, nullable: true
          field :dubbing_concurrency_limit, -> { ::Elevenlabs::ServiceAccounts::APIKeys::Types::BodyEditServiceAccountApiKeyV1ServiceAccountsServiceAccountUserIdApiKeysApiKeyIdPatchDubbingConcurrencyLimit }, optional: true, nullable: true
          field :music_concurrency_limit, -> { ::Elevenlabs::ServiceAccounts::APIKeys::Types::BodyEditServiceAccountApiKeyV1ServiceAccountsServiceAccountUserIdApiKeysApiKeyIdPatchMusicConcurrencyLimit }, optional: true, nullable: true
          field :expires_at_unix, -> { ::Elevenlabs::ServiceAccounts::APIKeys::Types::BodyEditServiceAccountApiKeyV1ServiceAccountsServiceAccountUserIdApiKeysApiKeyIdPatchExpiresAtUnix }, optional: true, nullable: false

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
