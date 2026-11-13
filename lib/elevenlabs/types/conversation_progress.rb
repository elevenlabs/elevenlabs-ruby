# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationProgress < ::Elevenlabs::Internal::Types::Model
      field :scheduled, -> { Integer }, optional: false, nullable: false
      field :scheduled_by_type, -> { ::Elevenlabs::Internal::Types::Hash[String, Integer] }, optional: false, nullable: false
      field :awaiting_permission, -> { Integer }, optional: false, nullable: false
      field :in_progress, -> { Integer }, optional: false, nullable: false
      field :awaiting_analysis, -> { Integer }, optional: false, nullable: false

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
