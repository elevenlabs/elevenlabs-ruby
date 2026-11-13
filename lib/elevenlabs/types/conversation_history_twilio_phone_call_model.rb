# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationHistoryTwilioPhoneCallModel < ::Elevenlabs::Internal::Types::Model
      field :direction, -> { ::Elevenlabs::Types::TelephonyDirection }, optional: false, nullable: false
      field :phone_number_id, -> { String }, optional: false, nullable: false
      field :agent_number, -> { String }, optional: false, nullable: false
      field :external_number, -> { String }, optional: false, nullable: false
      field :call_result, -> { ::Elevenlabs::Types::CallResult }, optional: true, nullable: true
      field :type, -> { ::Elevenlabs::Types::ConversationHistoryTwilioPhoneCallModelType }, optional: false, nullable: false
      field :stream_sid, -> { String }, optional: false, nullable: false
      field :call_sid, -> { String }, optional: false, nullable: false

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
