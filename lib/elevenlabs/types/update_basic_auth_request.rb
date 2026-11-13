# frozen_string_literal: true

module Elevenlabs
  module Types
    class UpdateBasicAuthRequest < ::Elevenlabs::Internal::Types::Model
      field :auth_type, -> { ::Elevenlabs::Types::UpdateBasicAuthRequestAuthType }, optional: true, nullable: false
      field :provider, -> { String }, optional: true, nullable: true
      field :username, -> { String }, optional: true, nullable: true
      field :password, -> { String }, optional: true, nullable: true

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
