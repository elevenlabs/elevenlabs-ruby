# frozen_string_literal: true

module Elevenlabs
  module Types
    class LeadDetailResponse < ::Elevenlabs::Internal::Types::Model
      field :lead_id, -> { String }, optional: false, nullable: false
      field :recipient_id, -> { String }, optional: false, nullable: true
      field :phone_number, -> { String }, optional: false, nullable: false
      field :phone_numbers, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :phone_numbers_index, -> { Integer }, optional: false, nullable: false
      field :user_id, -> { String }, optional: false, nullable: false
      field :attempt_count, -> { Integer }, optional: false, nullable: false
      field :failure_count, -> { Integer }, optional: false, nullable: false
      field :callback_count, -> { Integer }, optional: false, nullable: false
      field :redirect_count, -> { Integer }, optional: false, nullable: false
      field :do_not_call, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :terminal_disposition, -> { ::Elevenlabs::Types::TerminalDisposition }, optional: false, nullable: false
      field :created_at_unix, -> { Integer }, optional: false, nullable: true
      field :updated_at_unix, -> { Integer }, optional: false, nullable: false
      field :dynamic_variables, -> { Object }, optional: false, nullable: false
      field :overrides, -> { ::Elevenlabs::Types::FlattenedConfigOverrides }, optional: false, nullable: false
      field :delivery, -> { ::Elevenlabs::Types::LeadDeliveryView }, optional: true, nullable: false

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
