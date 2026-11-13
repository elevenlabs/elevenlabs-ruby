# frozen_string_literal: true

module Elevenlabs
  module Types
    class TestRunResultSummary < ::Elevenlabs::Internal::Types::Model
      field :test_id, -> { String }, optional: false, nullable: false
      field :test_name, -> { String }, optional: false, nullable: false
      field :workflow_node_id, -> { String }, optional: true, nullable: true
      field :buckets, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TestRunResultBucket] }, optional: false, nullable: false

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
