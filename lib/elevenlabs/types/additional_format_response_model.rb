# frozen_string_literal: true

module Elevenlabs
  module Types
    class AdditionalFormatResponseModel < ::Elevenlabs::Internal::Types::Model
      field :requested_format, -> { String }, optional: false, nullable: false
      field :file_extension, -> { String }, optional: false, nullable: false
      field :content_type, -> { String }, optional: false, nullable: false
      field :is_base64encoded, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false, api_name: 'is_base64_encoded'
      field :content, -> { String }, optional: false, nullable: false

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
