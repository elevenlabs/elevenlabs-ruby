# frozen_string_literal: true

module Elevenlabs
  module Types
    class TransferToNumberResultTwilioSuccessModel < ::Elevenlabs::Internal::Types::Model
      field :result_type, -> { ::Elevenlabs::Types::TransferToNumberResultTwilioSuccessModelResultType }, optional: true, nullable: false
      field :status, -> { ::Elevenlabs::Types::TransferToNumberResultTwilioSuccessModelStatus }, optional: true, nullable: false
      field :transfer_number, -> { String }, optional: false, nullable: false
      field :reason, -> { String }, optional: true, nullable: true
      field :client_message, -> { String }, optional: true, nullable: true
      field :agent_message, -> { String }, optional: false, nullable: false
      field :conference_name, -> { String }, optional: false, nullable: false
      field :post_dial_digits, -> { String }, optional: true, nullable: true
      field :note, -> { String }, optional: true, nullable: true

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
