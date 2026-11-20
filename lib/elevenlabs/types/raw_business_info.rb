# frozen_string_literal: true

module Elevenlabs
  module Types
    class RawBusinessInfo < ::Elevenlabs::Internal::Types::Model
      field :company_name, -> { String }, optional: true, nullable: true
      field :description, -> { String }, optional: true, nullable: true
      field :business_phone, -> { String }, optional: true, nullable: true
      field :locations, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::RawLocationInfo] }, optional: true, nullable: false
      field :business_country, -> { String }, optional: true, nullable: true
      field :business_state, -> { String }, optional: true, nullable: true
      field :suggested_currency, -> { String }, optional: true, nullable: true
      field :suggested_language, -> { String }, optional: true, nullable: true

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
