# frozen_string_literal: true

module Elevenlabs
  module Types
    class DeviceModel < ::Elevenlabs::Internal::Types::Model
      field :ip, -> { String }, optional: true, nullable: true
      field :hostname, -> { String }, optional: true, nullable: true
      field :type_id, -> { Integer }, optional: true, nullable: false

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
