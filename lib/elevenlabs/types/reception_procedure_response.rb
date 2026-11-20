# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionProcedureResponse < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :trigger, -> { String }, optional: false, nullable: false
      field :body, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: true, nullable: false
      field :created_at_unix, -> { Integer }, optional: true, nullable: false
      field :source_key, -> { String }, optional: true, nullable: true
      field :missing_tools, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(body, 'body', max_length: 40_000)
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
