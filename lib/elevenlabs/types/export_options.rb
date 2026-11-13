# frozen_string_literal: true

module Elevenlabs
  module Types
    module ExportOptions
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :format
      member -> { ::Elevenlabs::Types::DocxExportOptions }, key: 'docx'
      member -> { ::Elevenlabs::Types::HTMLExportOptions }, key: 'html'
      member -> { ::Elevenlabs::Types::PdfExportOptions }, key: 'pdf'
      member -> { ::Elevenlabs::Types::SegmentedJSONExportOptions }, key: 'segmented_json'
      member -> { ::Elevenlabs::Types::SrtExportOptions }, key: 'srt'
      member -> { ::Elevenlabs::Types::TxtExportOptions }, key: 'txt'

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
