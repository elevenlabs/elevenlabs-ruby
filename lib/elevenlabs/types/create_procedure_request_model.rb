# frozen_string_literal: true

module Elevenlabs
  module Types
    class CreateProcedureRequestModel < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: true, nullable: false
      field :content, -> { String }, optional: true, nullable: false
      field :type, -> { ::Elevenlabs::Types::ProcedureType }, optional: true, nullable: false
      field :trigger, -> { String }, optional: true, nullable: true
      field :folder_parent_id, -> { String }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_string!(name, 'name', max_length: 200)
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
