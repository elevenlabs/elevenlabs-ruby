# frozen_string_literal: true

module Elevenlabs
  module Types
    class UpdateAssetParams < ::Elevenlabs::Internal::Types::Model
      field :smb_tool_type, -> { ::Elevenlabs::Types::UpdateAssetParamsSmbToolType }, optional: true, nullable: false
      field :per_resource_timezones, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
