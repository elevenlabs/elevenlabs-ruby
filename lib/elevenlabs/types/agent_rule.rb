# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentRule < ::Elevenlabs::Internal::Types::Model
      field :title, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :priority, -> { ::Elevenlabs::Types::RulePriority }, optional: true, nullable: false
      field :id, -> { String }, optional: true, nullable: false
      field :created_at_unix, -> { Integer }, optional: true, nullable: false

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
