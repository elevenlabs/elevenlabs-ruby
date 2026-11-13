# frozen_string_literal: true

module Elevenlabs
  module Types
    class BatchCallDetailedResponse < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :phone_number_id, -> { String }, optional: false, nullable: true
      field :phone_provider, -> { ::Elevenlabs::Types::TelephonyProvider }, optional: false, nullable: false
      field :whatsapp_params, -> { ::Elevenlabs::Types::BatchCallWhatsAppParams }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :agent_id, -> { String }, optional: false, nullable: false
      field :branch_id, -> { String }, optional: false, nullable: true
      field :environment, -> { String }, optional: false, nullable: true
      field :created_at_unix, -> { Integer }, optional: false, nullable: false
      field :scheduled_time_unix, -> { Integer }, optional: false, nullable: false
      field :timezone, -> { String }, optional: false, nullable: true
      field :total_calls_dispatched, -> { Integer }, optional: false, nullable: false
      field :total_calls_scheduled, -> { Integer }, optional: false, nullable: false
      field :total_calls_finished, -> { Integer }, optional: false, nullable: false
      field :last_updated_at_unix, -> { Integer }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::BatchCallStatus }, optional: false, nullable: false
      field :retry_count, -> { Integer }, optional: false, nullable: false
      field :telephony_call_config, -> { ::Elevenlabs::Types::TelephonyCallConfigOutput }, optional: false, nullable: false
      field :target_concurrency_limit, -> { Integer }, optional: false, nullable: true
      field :agent_name, -> { String }, optional: false, nullable: false
      field :branch_name, -> { String }, optional: false, nullable: true
      field :recipients, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::OutboundCallRecipientResponseModel] }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(target_concurrency_limit, 'target_concurrency_limit', min: 1)
      end

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
