# frozen_string_literal: true

module Elevenlabs
  module Types
    class SipLogMessage < ::Elevenlabs::Internal::Types::Model
      field :call_id, -> { String }, optional: false, nullable: false
      field :phone_numbers, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :local_address, -> { String }, optional: false, nullable: false
      field :remote_address, -> { String }, optional: false, nullable: false
      field :transport, -> { String }, optional: false, nullable: false
      field :raw_message, -> { String }, optional: false, nullable: false
      field :error_message, -> { String }, optional: false, nullable: false
      field :direction, -> { ::Elevenlabs::Types::SipLogMessageDirection }, optional: false, nullable: false
      field :created_at_unix_micro, -> { Integer }, optional: false, nullable: false

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
