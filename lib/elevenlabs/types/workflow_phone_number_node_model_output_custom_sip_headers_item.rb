# frozen_string_literal: true

module Elevenlabs
  module Types
    module WorkflowPhoneNumberNodeModelOutputCustomSipHeadersItem
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::CustomSipHeaderWithDynamicVariable }, key: 'dynamic'
      member -> { ::Elevenlabs::Types::CustomSipHeader }, key: 'static'

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
