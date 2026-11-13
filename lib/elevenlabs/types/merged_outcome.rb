# frozen_string_literal: true

module Elevenlabs
  module Types
    class MergedOutcome < ::Elevenlabs::Internal::Types::Model
      field :status, -> { ::Elevenlabs::Types::MergedOutcomeStatus }, optional: true, nullable: false
      field :version_id, -> { String }, optional: false, nullable: false
      field :at, -> { Integer }, optional: false, nullable: false
      field :by_user_id, -> { String }, optional: false, nullable: true

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
