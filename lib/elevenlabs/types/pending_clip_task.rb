# frozen_string_literal: true

module Elevenlabs
  module Types
    class PendingClipTask < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::PendingClipTaskType }, optional: false, nullable: false
      field :progress, -> { Float }, optional: true, nullable: false
      field :started_at_ms, -> { Integer }, optional: true, nullable: false
      field :updated_at_ms, -> { Integer }, optional: true, nullable: false
      field :metadata, -> { Object }, optional: true, nullable: false

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
