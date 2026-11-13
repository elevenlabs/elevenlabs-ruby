# frozen_string_literal: true

module Elevenlabs
  module Types
    class DeliverableInfo < ::Elevenlabs::Internal::Types::Model
      field :signed_url, -> { String }, optional: false, nullable: false
      field :content_type, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :version, -> { Integer }, optional: true, nullable: false

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
