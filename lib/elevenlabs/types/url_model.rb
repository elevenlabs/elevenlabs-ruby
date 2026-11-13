# frozen_string_literal: true

module Elevenlabs
  module Types
    class URLModel < ::Elevenlabs::Internal::Types::Model
      field :url_string, -> { String }, optional: true, nullable: true
      field :scheme, -> { String }, optional: true, nullable: true
      field :hostname, -> { String }, optional: true, nullable: true
      field :port, -> { Integer }, optional: true, nullable: true
      field :path, -> { String }, optional: true, nullable: true
      field :query_string, -> { String }, optional: true, nullable: true

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
