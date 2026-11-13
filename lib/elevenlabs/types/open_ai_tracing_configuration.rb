# frozen_string_literal: true

module Elevenlabs
  module Types
    class OpenAiTracingConfiguration < ::Elevenlabs::Internal::Types::Model
      field :group_id, -> { String }, optional: true, nullable: true
      field :workflow_name, -> { String }, optional: true, nullable: true
      field :metadata, -> { Object }, optional: true, nullable: true

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
