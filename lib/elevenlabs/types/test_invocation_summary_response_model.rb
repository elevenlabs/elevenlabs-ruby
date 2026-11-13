# frozen_string_literal: true

module Elevenlabs
  module Types
    class TestInvocationSummaryResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: true, nullable: true
      field :agent_id, -> { String }, optional: true, nullable: true
      field :branch_id, -> { String }, optional: true, nullable: true
      field :version_id, -> { String }, optional: true, nullable: true
      field :ran_against_draft, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :runs_diverged_from_version, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :created_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :test_run_count, -> { Integer }, optional: false, nullable: false
      field :passed_count, -> { Integer }, optional: false, nullable: false
      field :failed_count, -> { Integer }, optional: false, nullable: false
      field :pending_count, -> { Integer }, optional: false, nullable: false
      field :cancelled_count, -> { Integer }, optional: false, nullable: false
      field :title, -> { String }, optional: false, nullable: false
      field :access_info, -> { ::Elevenlabs::Types::ResourceAccessInfo }, optional: true, nullable: false
      field :repeat_count, -> { Integer }, optional: true, nullable: false
      field :cancelled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :credits_used, -> { Integer }, optional: true, nullable: true
      field :total_price, -> { Float }, optional: true, nullable: true

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
