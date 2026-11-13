# frozen_string_literal: true

module Elevenlabs
  module Types
    class TestRunResultBucket < ::Elevenlabs::Internal::Types::Model
      field :test_run_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :title, -> { String }, optional: false, nullable: false
      field :reason, -> { String }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::TestRunStatus }, optional: false, nullable: false

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
