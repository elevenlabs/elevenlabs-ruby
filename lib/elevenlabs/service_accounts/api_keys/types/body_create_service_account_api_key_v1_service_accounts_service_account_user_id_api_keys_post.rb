# frozen_string_literal: true

module Elevenlabs
  module ServiceAccounts
    module APIKeys
      module Types
        class BodyCreateServiceAccountApiKeyV1ServiceAccountsServiceAccountUserIdApiKeysPost < ::Elevenlabs::Internal::Types::Model
          field :name, -> { String }, optional: false, nullable: false
          field :permissions, -> { ::Elevenlabs::ServiceAccounts::APIKeys::Types::BodyCreateServiceAccountApiKeyV1ServiceAccountsServiceAccountUserIdApiKeysPostPermissions }, optional: false, nullable: false
          field :character_limit, -> { Integer }, optional: true, nullable: true
          field :allowed_ips, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
          field :third_party_disable_allowed, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
          field :tts_concurrency_limit, -> { Integer }, optional: true, nullable: true
          field :dubbing_concurrency_limit, -> { Integer }, optional: true, nullable: true
          field :music_concurrency_limit, -> { Integer }, optional: true, nullable: true
          field :expires_at_unix, -> { Integer }, optional: true, nullable: true

          def validate!
            ::Elevenlabs::Validator.validate_array!(allowed_ips, 'allowed_ips', min_items: 1, max_items: 100)
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
