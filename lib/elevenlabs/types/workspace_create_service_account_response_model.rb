# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkspaceCreateServiceAccountResponseModel < ::Elevenlabs::Internal::Types::Model
      field :service_account_user_id, -> { String }, optional: false, nullable: false, api_name: 'service-account-user-id'

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
