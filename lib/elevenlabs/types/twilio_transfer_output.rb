# frozen_string_literal: true

module Elevenlabs
  module Types
    class TwilioTransferOutput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::TwilioTransferOutputType }, optional: false, nullable: false
      field :config, -> { ::Elevenlabs::Types::TwilioTransferOutputConfig }, optional: false, nullable: false

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
