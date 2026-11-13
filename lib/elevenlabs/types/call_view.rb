# frozen_string_literal: true

module Elevenlabs
  module Types
    class CallView < ::Elevenlabs::Internal::Types::Model
      field :intent_id, -> { String }, optional: false, nullable: false
      field :lead_id, -> { String }, optional: false, nullable: false
      field :intent_type, -> { ::Elevenlabs::Types::CampaignConversationType }, optional: false, nullable: false
      field :cold_attempt, -> { Integer }, optional: false, nullable: true
      field :status, -> { ::Elevenlabs::Types::CallStatus }, optional: false, nullable: false
      field :phone_number, -> { String }, optional: false, nullable: false
      field :scheduled_time_unix, -> { Integer }, optional: false, nullable: false
      field :conversation_id, -> { String }, optional: false, nullable: true
      field :outcome, -> { ::Elevenlabs::Types::BatchCallRecipientStatus }, optional: false, nullable: false
      field :call_result, -> { ::Elevenlabs::Types::CallResult }, optional: false, nullable: false
      field :outcome_at_unix, -> { Integer }, optional: false, nullable: true
      field :decision_disposition, -> { ::Elevenlabs::Types::DecisionDisposition }, optional: false, nullable: true
      field :collected_dynamic_variables, -> { Object }, optional: true, nullable: false
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
