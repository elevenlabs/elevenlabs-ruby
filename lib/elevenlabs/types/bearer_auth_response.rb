# frozen_string_literal: true

module Elevenlabs
  module Types
    class BearerAuthResponse < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :auth_type, -> { ::Elevenlabs::Types::BearerAuthResponseAuthType }, optional: true, nullable: false
      field :provider, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :used_by, -> { ::Elevenlabs::Types::AuthConnectionDependencies }, optional: true, nullable: false
      field :status, -> { ::Elevenlabs::Types::AuthConnectionStatus }, optional: true, nullable: false
      field :status_detail, -> { String }, optional: true, nullable: true
      field :status_updated_at, -> { String }, optional: true, nullable: true

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
