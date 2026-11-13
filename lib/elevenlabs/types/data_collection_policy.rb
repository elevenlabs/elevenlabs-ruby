# frozen_string_literal: true

module Elevenlabs
  module Types
    class DataCollectionPolicy < ::Elevenlabs::Internal::Types::Model
      field :callback_time, -> { String }, optional: true, nullable: true
      field :redirect_phone_number, -> { String }, optional: true, nullable: true
      field :stop, -> { String }, optional: true, nullable: true
      field :mappings, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false

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
