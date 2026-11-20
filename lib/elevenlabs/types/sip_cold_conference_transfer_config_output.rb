# frozen_string_literal: true

module Elevenlabs
  module Types
    class SipColdConferenceTransferConfigOutput < ::Elevenlabs::Internal::Types::Model
      field :transfer_destination, -> { ::Elevenlabs::Types::SipColdConferenceTransferConfigOutputTransferDestination }, optional: false, nullable: false
      field :type, -> { ::Elevenlabs::Types::SipColdConferenceTransferConfigOutputType }, optional: false, nullable: false

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
