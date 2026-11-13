# frozen_string_literal: true

module Elevenlabs
  module Types
    class UtteranceResponseModel < ::Elevenlabs::Internal::Types::Model
      field :start, -> { Float }, optional: false, nullable: false
      field :end_, -> { Float }, optional: false, nullable: false, api_name: 'end'

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
