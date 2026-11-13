# frozen_string_literal: true

module Elevenlabs
  module Types
    class TestsFeatureUsageCommonModel < ::Elevenlabs::Internal::Types::Model
      field :enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :tests_ran_after_last_modification, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :tests_ran_in_last7days, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false, api_name: 'tests_ran_in_last_7_days'

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
