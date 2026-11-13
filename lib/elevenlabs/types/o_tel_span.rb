# frozen_string_literal: true

module Elevenlabs
  module Types
    class OTelSpan < ::Elevenlabs::Internal::Types::Model
      field :trace_id, -> { String }, optional: false, nullable: false, api_name: 'traceId'
      field :span_id, -> { String }, optional: false, nullable: false, api_name: 'spanId'
      field :parent_span_id, -> { String }, optional: true, nullable: true, api_name: 'parentSpanId'
      field :name, -> { String }, optional: false, nullable: false
      field :kind, -> { Integer }, optional: false, nullable: false
      field :start_time_unix_nano, -> { String }, optional: false, nullable: false, api_name: 'startTimeUnixNano'
      field :end_time_unix_nano, -> { String }, optional: false, nullable: false, api_name: 'endTimeUnixNano'
      field :attributes, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::OTelAttribute] }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::OTelStatus }, optional: false, nullable: false

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
