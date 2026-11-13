# frozen_string_literal: true

module Elevenlabs
  module Types
    class OTelTracePayload < ::Elevenlabs::Internal::Types::Model
      field :resource_spans, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::OTelResourceSpans] }, optional: false, nullable: false, api_name: 'resourceSpans'

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
