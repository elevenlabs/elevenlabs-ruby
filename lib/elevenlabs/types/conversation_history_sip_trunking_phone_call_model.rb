# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationHistorySipTrunkingPhoneCallModel < ::Elevenlabs::Internal::Types::Model
      field :direction, -> { ::Elevenlabs::Types::TelephonyDirection }, optional: false, nullable: false
      field :phone_number_id, -> { String }, optional: false, nullable: false
      field :agent_number, -> { String }, optional: false, nullable: false
      field :external_number, -> { String }, optional: false, nullable: false
      field :call_result, -> { ::Elevenlabs::Types::CallResult }, optional: true, nullable: false
      field :type, -> { ::Elevenlabs::Types::ConversationHistorySipTrunkingPhoneCallModelType }, optional: false, nullable: false
      field :call_id, -> { String }, optional: true, nullable: true
      field :call_sid, -> { String }, optional: false, nullable: false
      field :sip_header_dynamic_variables, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false

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
