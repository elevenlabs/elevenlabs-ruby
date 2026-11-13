# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowPhoneNumberNodeModelOutput < ::Elevenlabs::Internal::Types::Model
      field :custom_sip_headers, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WorkflowPhoneNumberNodeModelOutputCustomSipHeadersItem] }, optional: false, nullable: false
      field :transfer_destination, -> { ::Elevenlabs::Types::WorkflowPhoneNumberNodeModelOutputTransferDestination }, optional: false, nullable: false
      field :transfer_type, -> { ::Elevenlabs::Types::TransferTypeEnum }, optional: false, nullable: false
      field :sip_refer_play_dialtone, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :uui, -> { ::Elevenlabs::Types::UuiTransferConfig }, optional: false, nullable: false
      field :post_dial_digits, -> { ::Elevenlabs::Types::WorkflowPhoneNumberNodeModelOutputPostDialDigits }, optional: false, nullable: true
      field :type, -> { ::Elevenlabs::Types::WorkflowPhoneNumberNodeModelOutputType }, optional: false, nullable: false
      field :position, -> { ::Elevenlabs::Types::PositionOutput }, optional: false, nullable: false
      field :edge_order, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false

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
