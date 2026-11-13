# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkspaceServiceAccountResponseModel < ::Elevenlabs::Internal::Types::Model
      field :service_account_user_id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :created_at_unix, -> { Integer }, optional: true, nullable: true
      field :api_keys, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WorkspaceAPIKeyResponseModel] }, optional: false, nullable: false, api_name: 'api-keys'
      field :default_sharing_groups, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DefaultSharingGroupResponseModel] }, optional: true, nullable: false

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
