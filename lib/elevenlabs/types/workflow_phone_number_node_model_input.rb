# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowPhoneNumberNodeModelInput < ::Elevenlabs::Internal::Types::Model
      field :custom_sip_headers, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WorkflowPhoneNumberNodeModelInputCustomSipHeadersItem] }, optional: true, nullable: false
      field :transfer_destination, -> { ::Elevenlabs::Types::WorkflowPhoneNumberNodeModelInputTransferDestination }, optional: false, nullable: false
      field :transfer_type, -> { ::Elevenlabs::Types::TransferTypeEnum }, optional: true, nullable: false
      field :sip_refer_play_dialtone, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :uui, -> { ::Elevenlabs::Types::UuiTransferConfig }, optional: true, nullable: false
      field :post_dial_digits, -> { ::Elevenlabs::Types::WorkflowPhoneNumberNodeModelInputPostDialDigits }, optional: true, nullable: true
      field :type, -> { ::Elevenlabs::Types::WorkflowPhoneNumberNodeModelInputType }, optional: true, nullable: false
      field :position, -> { ::Elevenlabs::Types::PositionInput }, optional: true, nullable: false
      field :edge_order, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false

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
