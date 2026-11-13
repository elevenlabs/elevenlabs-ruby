# frozen_string_literal: true

module Elevenlabs
  module Types
    class PhoneNumberTransfer < ::Elevenlabs::Internal::Types::Model
      field :custom_sip_headers, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::PhoneNumberTransferCustomSipHeadersItem] }, optional: true, nullable: false
      field :transfer_destination, -> { ::Elevenlabs::Types::PhoneNumberTransferTransferDestination }, optional: false, nullable: false
      field :transfer_type, -> { ::Elevenlabs::Types::TransferTypeEnum }, optional: true, nullable: false
      field :sip_refer_play_dialtone, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :uui, -> { ::Elevenlabs::Types::UuiTransferConfig }, optional: true, nullable: true
      field :post_dial_digits, -> { ::Elevenlabs::Types::PhoneNumberTransferPostDialDigits }, optional: true, nullable: true
      field :phone_number, -> { String }, optional: true, nullable: true
      field :condition, -> { String }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(custom_sip_headers, 'custom_sip_headers', max_items: 20)
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
