# frozen_string_literal: true

module Elevenlabs
  module Types
    class SmsConversationInfo < ::Elevenlabs::Internal::Types::Model
      field :direction, -> { ::Elevenlabs::Types::SmsConversationInfoDirection }, optional: false, nullable: false
      field :phone_number_id, -> { String }, optional: true, nullable: true
      field :sms_user_phone_number, -> { String }, optional: false, nullable: false
      field :agent_phone_number, -> { String }, optional: true, nullable: true

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
