# frozen_string_literal: true

module Elevenlabs
  module Types
    class HTTPRequestModel < ::Elevenlabs::Internal::Types::Model
      field :http_method, -> { String }, optional: false, nullable: false
      field :url, -> { ::Elevenlabs::Types::URLModel }, optional: false, nullable: false
      field :user_agent, -> { String }, optional: true, nullable: true
      field :x_forwarded_for, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

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
