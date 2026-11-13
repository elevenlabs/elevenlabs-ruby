# frozen_string_literal: true

module Elevenlabs
  module Types
    class ResourceAccessInfo < ::Elevenlabs::Internal::Types::Model
      field :is_creator, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :creator_name, -> { String }, optional: false, nullable: false
      field :creator_email, -> { String }, optional: false, nullable: false
      field :role, -> { ::Elevenlabs::Types::ResourceAccessInfoRole }, optional: false, nullable: false
      field :anonymous_access_level_override, -> { ::Elevenlabs::Types::ResourceAccessInfoAnonymousAccessLevelOverride }, optional: true, nullable: true
      field :access_source, -> { ::Elevenlabs::Types::ResourceAccessInfoAccessSource }, optional: true, nullable: true

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
