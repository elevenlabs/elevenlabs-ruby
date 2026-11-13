# frozen_string_literal: true

module Elevenlabs
  module Types
    class PlatformLimits < ::Elevenlabs::Internal::Types::Model
      field :credits, -> { ::Elevenlabs::Types::StoredUsagePlatformLimit }, optional: true, nullable: false
      field :pvc, -> { ::Elevenlabs::Types::ComputedUsagePlatformLimit }, optional: true, nullable: false
      field :concurrency, -> { ::Elevenlabs::Types::ComputedUsagePlatformLimit }, optional: true, nullable: false
      field :dubbing_concurrency, -> { ::Elevenlabs::Types::ComputedUsagePlatformLimit }, optional: true, nullable: false
      field :music_concurrency, -> { ::Elevenlabs::Types::ComputedUsagePlatformLimit }, optional: true, nullable: false

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
