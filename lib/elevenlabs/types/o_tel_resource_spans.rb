# frozen_string_literal: true

module Elevenlabs
  module Types
    class OTelResourceSpans < ::Elevenlabs::Internal::Types::Model
      field :resource, -> { ::Elevenlabs::Types::OTelResource }, optional: false, nullable: false
      field :scope_spans, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::OTelScopeSpans] }, optional: false, nullable: false, api_name: 'scopeSpans'

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
