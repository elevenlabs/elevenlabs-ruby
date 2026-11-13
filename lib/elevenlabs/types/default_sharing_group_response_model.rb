# frozen_string_literal: true

module Elevenlabs
  module Types
    class DefaultSharingGroupResponseModel < ::Elevenlabs::Internal::Types::Model
      field :group, -> { ::Elevenlabs::Types::WorkspaceGroupResponseModel }, optional: false, nullable: false
      field :permission_level, -> { ::Elevenlabs::Types::DefaultSharingGroupResponseModelPermissionLevel }, optional: false, nullable: false

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
