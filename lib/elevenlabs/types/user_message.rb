# frozen_string_literal: true

module Elevenlabs
  module Types
    class UserMessage < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: true, nullable: false
      field :type, -> { ::Elevenlabs::Types::UserMessageType }, optional: true, nullable: false
      field :text, -> { String }, optional: true, nullable: false
      field :user_identifier, -> { String }, optional: true, nullable: false
      field :source_medium, -> { ::Elevenlabs::Types::UserMessageSourceMedium }, optional: true, nullable: false

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
