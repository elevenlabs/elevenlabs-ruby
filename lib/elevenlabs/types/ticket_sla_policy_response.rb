# frozen_string_literal: true

module Elevenlabs
  module Types
    class TicketSLAPolicyResponse < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: true
      field :targets, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TicketSLAPolicyTargetOutput] }, optional: false, nullable: false
      field :archived, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :created_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :updated_at_unix_secs, -> { Integer }, optional: false, nullable: false

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
