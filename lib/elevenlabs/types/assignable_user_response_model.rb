# frozen_string_literal: true

module Elevenlabs
  module Types
    class AssignableUserResponseModel < ::Elevenlabs::Internal::Types::Model
      field :user_id, -> { String }, optional: false, nullable: false
      field :email, -> { String }, optional: false, nullable: false
      field :first_name, -> { String }, optional: false, nullable: true
      field :is_service_account, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :has_access, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
