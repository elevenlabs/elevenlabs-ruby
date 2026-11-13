# frozen_string_literal: true

module Elevenlabs
  module Types
    module AnalysisType
      extend ::Elevenlabs::Internal::Types::Enum

      EVALUATION_CRITERIA = :evaluation_criteria
      DATA_COLLECTION = :data_collection

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
