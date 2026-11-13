# frozen_string_literal: true

module Elevenlabs
  module Types
    class FieldConflict < ::Elevenlabs::Internal::Types::Model
      field :path, -> { String }, optional: false, nullable: false
      field :section, -> { ::Elevenlabs::Types::ConflictSection }, optional: false, nullable: false
      field :base_value, -> { Object }, optional: true, nullable: false
      field :source_value, -> { Object }, optional: true, nullable: false
      field :target_value, -> { Object }, optional: true, nullable: false

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
