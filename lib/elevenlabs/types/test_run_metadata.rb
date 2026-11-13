# frozen_string_literal: true

module Elevenlabs
  module Types
    class TestRunMetadata < ::Elevenlabs::Internal::Types::Model
      field :workspace_id, -> { String }, optional: false, nullable: false
      field :test_name, -> { String }, optional: false, nullable: false
      field :ran_by_user_email, -> { String }, optional: false, nullable: false
      field :test_type, -> { ::Elevenlabs::Types::TestRunMetadataTestType }, optional: true, nullable: false

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
