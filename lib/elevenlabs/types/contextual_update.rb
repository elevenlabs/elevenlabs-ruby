# frozen_string_literal: true

module Elevenlabs
  module Types
    class ContextualUpdate < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::ContextualUpdateType }, optional: true, nullable: false
      field :text, -> { String }, optional: false, nullable: false
      field :context_id, -> { String }, optional: true, nullable: false

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
