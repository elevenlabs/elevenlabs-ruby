# frozen_string_literal: true

module Elevenlabs
  module Types
    class SampleConfigDbModel < ::Elevenlabs::Internal::Types::Model
      field :is_sample, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :parent_id, -> { String }, optional: true, nullable: true
      field :parent_type, -> { ::Elevenlabs::Types::SampleConfigDbModelParentType }, optional: true, nullable: true
      field :chapter_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

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
