# frozen_string_literal: true

module Elevenlabs
  module Types
    class ExotelOutboundCallResponse < ::Elevenlabs::Internal::Types::Model
      field :success, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :message, -> { String }, optional: false, nullable: false
      field :conversation_id, -> { String }, optional: false, nullable: true
      field :call_sid, -> { String }, optional: false, nullable: true, api_name: 'callSid'

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
