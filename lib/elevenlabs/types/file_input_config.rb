# frozen_string_literal: true

module Elevenlabs
  module Types
    class FileInputConfig < ::Elevenlabs::Internal::Types::Model
      field :enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :max_files_in_memory, -> { Integer }, optional: true, nullable: false
      field :max_files_per_conversation, -> { Integer }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(max_files_in_memory, 'max_files_in_memory', min: 1, max: 30)
      end

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
