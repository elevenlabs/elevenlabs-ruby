# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetTestSuiteInvocationResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: true, nullable: true
      field :agent_id, -> { String }, optional: true, nullable: true
      field :branch_id, -> { String }, optional: true, nullable: true
      field :version_id, -> { String }, optional: true, nullable: true
      field :ran_against_draft, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :created_at, -> { Integer }, optional: true, nullable: false
      field :folder_id, -> { String }, optional: true, nullable: true
      field :repeat_count, -> { Integer }, optional: true, nullable: false
      field :cancelled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :bucketing_status, -> { ::Elevenlabs::Types::BucketingStatus }, optional: true, nullable: true
      field :result_groups, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TestRunResultSummary] }, optional: true, nullable: false
      field :test_runs, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::UnitTestRunResponseModel] }, optional: false, nullable: false

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
