# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetVoicesV2Response < ::Elevenlabs::Internal::Types::Model
      field :voices, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::Voice] }, optional: false, nullable: false
      field :has_more, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :total_count, -> { Integer }, optional: false, nullable: false
      field :next_page_token, -> { String }, optional: true, nullable: true

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
