# frozen_string_literal: true

module Elevenlabs
  module Types
    class AttachedSystemDataCollectionRef < ::Elevenlabs::Internal::Types::Model
      field :source, -> { ::Elevenlabs::Types::AttachedSystemDataCollectionRefSource }, optional: false, nullable: false
      field :analysis_item_id, -> { ::Elevenlabs::Types::SystemDataCollectionID }, optional: false, nullable: false
      field :scope, -> { ::Elevenlabs::Types::AnalysisScope }, optional: true, nullable: false

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
