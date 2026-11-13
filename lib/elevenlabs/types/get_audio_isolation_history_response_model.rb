# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetAudioIsolationHistoryResponseModel < ::Elevenlabs::Internal::Types::Model
      field :items, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AudioIsolationHistoryItemResponseModel] }, optional: false, nullable: false
      field :has_more, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
