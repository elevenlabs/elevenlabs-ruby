# frozen_string_literal: true

module Elevenlabs
  module Types
    class FollowupContextPolicy < ::Elevenlabs::Internal::Types::Model
      field :call_type, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :previous_conversation_id, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :previous_summary, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :previous_transcript, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
