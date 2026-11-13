# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkspaceAPIKeyListResponseModel < ::Elevenlabs::Internal::Types::Model
      field :api_keys, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WorkspaceAPIKeyResponseModel] }, optional: false, nullable: false, api_name: 'api-keys'

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
