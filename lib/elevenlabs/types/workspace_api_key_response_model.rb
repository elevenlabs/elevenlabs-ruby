# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkspaceAPIKeyResponseModel < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :hint, -> { String }, optional: false, nullable: false
      field :key_id, -> { String }, optional: false, nullable: false
      field :service_account_user_id, -> { String }, optional: false, nullable: false
      field :created_at_unix, -> { Integer }, optional: true, nullable: true
      field :is_disabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :permissions, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::PermissionType] }, optional: true, nullable: true
      field :disable_reason, -> { ::Elevenlabs::Types::LockReason }, optional: true, nullable: true
      field :character_limit, -> { Integer }, optional: true, nullable: true
      field :character_count, -> { Integer }, optional: true, nullable: true
      field :hashed_xi_api_key, -> { String }, optional: false, nullable: false
      field :allowed_ips, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :third_party_disable_allowed, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :platform_limits, -> { ::Elevenlabs::Types::PlatformLimits }, optional: true, nullable: true
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
