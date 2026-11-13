# frozen_string_literal: true

module Elevenlabs
  module Types
    module AnalysisItemResponseModelDefinition
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :kind
      member -> { ::Elevenlabs::Types::UserDataCollectionAnalysisItemOutput }, key: 'data_collection'
      member -> { ::Elevenlabs::Types::UserEvaluationAnalysisItem }, key: 'evaluation'

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
