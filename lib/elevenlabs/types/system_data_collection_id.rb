# frozen_string_literal: true

module Elevenlabs
  module Types
    module SystemDataCollectionID
      extend ::Elevenlabs::Internal::Types::Enum

      V_SYSTEM_DATA_COLLECTION_TOPIC = :__system_data_collection_topic

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
