# frozen_string_literal: true

module Elevenlabs
  module Types
    class LeadDeliveryView < ::Elevenlabs::Internal::Types::Model
      field :status, -> { ::Elevenlabs::Types::BatchCallRecipientStatus }, optional: false, nullable: false
      field :stage, -> { ::Elevenlabs::Types::LeadDeliveryViewStage }, optional: false, nullable: false
      field :sent_at_unix, -> { Integer }, optional: false, nullable: true
      field :delivered_at_unix, -> { Integer }, optional: false, nullable: true
      field :read_at_unix, -> { Integer }, optional: false, nullable: true
      field :replied_at_unix, -> { Integer }, optional: false, nullable: true
      field :failed_at_unix, -> { Integer }, optional: false, nullable: true
      field :error_message, -> { String }, optional: false, nullable: true

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
