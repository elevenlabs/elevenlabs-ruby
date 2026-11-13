# frozen_string_literal: true

module Elevenlabs
  module Types
    class OpenAiFunctionTool < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::OpenAiFunctionToolType }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :parameters, -> { Object }, optional: true, nullable: false

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
